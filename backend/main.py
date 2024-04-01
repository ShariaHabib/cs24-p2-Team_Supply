import sqlite3
import json
from flask import Flask, jsonify, request, Response , session
import pyrebase
import os
from functools import wraps
import requests
import firebase_admin
from firebase_admin import auth as adminauth
import smtplib
from email.mime.text import MIMEText
from email.mime.multipart import MIMEMultipart
from flask_cors import CORS
import geopy.distance


firebaseConfig = {
  "apiKey": os.environ.get("FIREBASE_API_KEY"),
  "authDomain": os.environ.get("FIREBASE_AUTH_DOMAIN"),
  "databaseURL" : os.environ.get("FIREBASE_DATABASE_URL"),
  "projectId" : os.environ.get("FIREBASE_PROJECT_ID"),
  "storageBucket": os.environ.get("FIREBASE_STORAGE_BUCKET"),
  "messagingSenderId": os.environ.get("FIREBASE_MESSAGING_SENDER_ID"),
  "appId": os.environ.get("FIREBASE_APP_ID"),
  "measurementId": os.environ.get("FIREBASE_MEASUREMENT_ID"),
}

cred = firebase_admin.credentials.Certificate('codesamurai-d21e2-firebase-adminsdk-9mv4g-29f4abca75.json')
firebase_admin.initialize_app(cred)

firebase =pyrebase.initialize_app(firebaseConfig)
auth = firebase.auth()


app = Flask(__name__)
app.secret_key = os.environ.get("SECRET_KEY")
CORS(app, resources={r"/*": {"origins": ["http://localhost:8200", "http://127.0.0.1:8200"]}}, supports_credentials=True)




# Authentication Endpoints

@app.route("/auth/create", methods=["POST"])
def route_users():
    try:
        data = request.get_json()
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        user = auth.create_user_with_email_and_password(data["email"], data["password"])
        uid = user['localId']
        cursor.execute("INSERT INTO USER (user_id, email, user_name) VALUES (?, ?, ?)", (uid, data["email"] ,data["user_name"]))
        db.commit()
        cursor.execute("INSERT INTO USER_ROLE (user_id, role_id) VALUES (?, ?)",(uid,4))
        db.commit()
        db.close()
        return jsonify({"success":True, "message": "Registration successful"}),  201
    
    except requests.HTTPError as e:
        error_json = e.args[1]
        error = json.loads(error_json)['error']['message']
        if error == "EMAIL_EXISTS":
            return jsonify({"success": False, "message":"Account already exists"}), 400
        return jsonify({"success": False, "message":str(e)}), 400
    
    
@app.route('/auth/login', methods=['POST']) #success
def login():
    try:
        data = request.get_json()
        email = data['email']
        password = data['password']
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        cursor.execute("SELECT r.role_id FROM USER u JOIN ROLE r ON u.user_role = r.role_name WHERE u.email = ?",(email,))
        role_id = cursor.fetchone()[0]
        if role_id == 4:
            db.close()
            return jsonify({"success": False,'message': "Unauthorized Access"}), 401
        cursor.execute("SELECT user_name FROM USER WHERE email = ?",(email,))
        user_name = cursor.fetchone()[0]
        user = auth.sign_in_with_email_and_password(email, password)
        uid = user['localId']
        token = user['idToken']
        session['token'] = token
        return jsonify({"success": True,'message': 'Login successful', "userInfo":  {"user_name":user_name,"role_id":role_id,'user_id':uid}, 'token': token})
    except Exception as e:
        if type(e) == requests.exceptions.HTTPError:
            error_json = e.args[1]
            error = json.loads(error_json)['error']['message']
            if error == "INVALID_LOGIN_CREDENTIALS":
                return jsonify({"success": False, "message":"Invalid login credentials"}), 401
        return jsonify({"success": False, "message":str(e)}), 400


def login_required(f):
    @wraps(f)
    def decorated_function(*args, **kwargs):
        try:
            token = request.headers.get('Authorization')
            if token:
                user = auth.get_account_info(token)
                print(session.get('token'))
                if session.get('token'):
                    return f(user, *args, **kwargs)
                return jsonify({"success": False,'message': "Unauthorized Access"}), 401
            else:
                return jsonify({"success": False,'message': "Unauthorized Access"}), 401
        except requests.HTTPError as e:
            error_json = e.args[1]
            error = json.loads(error_json)['error']['message']
            if error == "INVALID_ID_TOKEN":
                return jsonify({"success": False,'message': "Unauthorized Access"}), 401
            return jsonify({"success": False,'message': str(e)}), 401
    return decorated_function



@app.route('/auth/logout',methods=['GET'])
def logout():
    session.clear()
    return jsonify({"success": True,'message': 'logout success'})


@app.route('/auth/reset-password/initiate',methods=['POST'])
def reset_password():
    try:
        data = request.get_json()
        email = data['email']
        link = adminauth.generate_password_reset_link(email=email)
        url_parts = link.split('&')
        oobcode = ""
        for part in url_parts:
            if 'oobCode=' in part:
                oobcode = part.split('=')[1]

        sender_email = os.environ.get("SENDER_EMAIL")
        sender_password = os.environ.get("SENDER_PASSWORD")
        msg = MIMEMultipart()
        msg['From'] = "noreply@codesamuraiteamsupply"
        msg['To'] = data['email']
        msg['Subject'] = "Reset your password for Application"
        message = f"Hello! You have requested to reset your password.\n\n"
        message += f"Please click on the following link to reset your password:\n"
        message += f"Your password reset code:  {oobcode}\n\n\n"
        message += f"If you didn't request this, please ignore this email. This link will expire in one hour.\n\n"

        msg.attach(MIMEText(message, 'plain'))

        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login(sender_email, sender_password)
        text = msg.as_string()
        server.sendmail(sender_email, email, text)
        server.quit()        

        return jsonify({"success": True,'message': 'A verification token has been sent to the mail address'}), 200
    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400

@app.route('/auth/reset-password/confirm',methods=['POST'])
def confirm_password():
    try:
        data = request.get_json()
        verificationToken = data['verification_token']
        newPassword = data['new_password']
        auth.verify_password_reset_code(verificationToken,newPassword)
        
        return jsonify({'success':True,'message': 'Password reset successfully'}), 200
    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400

@app.route('/auth/change-password',methods=['POST'])
def change_password():
    try:
        data = request.get_json()
        email = data['email']
        auth.send_password_reset_email(email=email)
        return jsonify({"success": True,'message': 'A verification email has been sent to the mail address'}), 200
    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400


def check_permission(loggedin_user_id, required_permissions, user_id = ""):
    try:
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        
        cursor.execute("SELECT role_id FROM USER_ROLE WHERE user_id = ?", (loggedin_user_id,))
        role_id = cursor.fetchone()

        if role_id is None:
            return False

        cursor.execute("""
            SELECT PERMISSION.permission_id FROM PERMISSION
            JOIN ROLE_PERMISSION ON PERMISSION.permission_id = ROLE_PERMISSION.permission_id
            WHERE ROLE_PERMISSION.role_id = ?
        """, (role_id[0],))
        permissions = cursor.fetchall()

        user_permissions = [perm[0] for perm in permissions]
        for permission in required_permissions:
            if permission in user_permissions:
                if permission == 4 or permission == 6:
                    if user_id == loggedin_user_id:
                        return True
                else:
                    return True

        return False

    except Exception as e:
        print(e)
        return False
    finally:
        db.close()

# User Management Endpoints

@app.route('/users',methods=['GET'])
@login_required
def get_users(user):
    try:
        uid = user['users'][0]['localId']
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        if not check_permission(uid,[2,]) :
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401

        cursor.execute("SELECT * FROM USER")
        users = cursor.fetchall()
        db.close()
        usersList = [{
            "user_id": user[0],
            "email": user[1],
            "user_name": user[2],
            "user_role": user[3]
        } for user in users]
        return jsonify({"success": True,'userList':usersList }), 200
    except Exception as e:
        print(e)
        return jsonify({"success": False,'message': str(e)}), 400
    

@app.route('/users/<roleId>',methods=['GET'])
@login_required
def get_users_by_role(user,roleId):
    try:
        print(roleId)
        uid = user['users'][0]['localId']
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        if not check_permission(uid,[2,]) :
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401

        cursor.execute("SELECT USER.user_id,user_name FROM USER JOIN ROLE ON USER.user_role = ROLE.role_name WHERE ROLE.role_id = ?",(roleId,))
        
        users = cursor.fetchall()
        print(users)
        db.close()
        usersList = [{
            "user_id": user[0],
            "user_name": user[1],
        } for user in users]
        return jsonify({"success": True,'userList':usersList }), 200
    except Exception as e:
        print(e)
        return jsonify({"success": False,'message': str(e)}), 400
    



@app.route('/users/<string:userId>',methods=['GET'])
@login_required
def get_single_users(user,userId):
    try:
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        uid = user['users'][0]['localId']
        if not check_permission(uid,[3,4,],userId) :
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401
        
        cursor.execute("SELECT * FROM USER WHERE user_id=?",(userId,))
        val = cursor.fetchone()
        db.close()
        userData = [{
            "user_id": val[0],
            "email": val[1],
            "user_name": val[2],
            "user_role": val[3]
        }]
        return jsonify({"success": True,'userData':userData }), 200
    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400

@app.route("/users", methods=["POST"]) #success
@login_required
def create_users(user):
    try:
        if not check_permission(user['users'][0]['localId'],[1]):
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401
        data = request.get_json()
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        user = auth.create_user_with_email_and_password(data["email"], data["password"])
        uid = user['localId']
        cursor.execute("INSERT INTO USER (user_id, email, user_name, user_role) VALUES (?, ?, ?, ?)", (uid, data["email"] ,data["user_name"],data['user_role'],))
        cursor.execute("SELECT role_id FROM ROLE WHERE role_name = ?",(data['user_role'],))
        role_id =  cursor.fetchone()[0]
        print(role_id)
        cursor.execute("INSERT INTO USER_ROLE (user_id, role_id) VALUES (?, ?)",(uid,role_id))
        db.commit()
        db.close()

        sender_email = os.environ.get("SENDER_EMAIL")
        sender_password = os.environ.get("SENDER_PASSWORD")
        msg = MIMEMultipart()
        msg['From'] = "noreply@codesamuraiteamsupply"
        msg['To'] = data['email']
        msg['Subject'] = "Your account registration for EcoSync"
        password = data["password"]
        message = f"Hello!\n Your Account has been created.\n\n"
        message += f"Please change your password after logging in. Use this email for logging in\n \n"
        message += f"Your temporary password is:  {password}\n\n\n"
        message += f"If you didn't request this, please ignore this email.\n\n"

        msg.attach(MIMEText(message, 'plain'))

        server = smtplib.SMTP('smtp.gmail.com', 587)
        server.starttls()
        server.login(sender_email, sender_password)
        text = msg.as_string()
        server.sendmail(sender_email, data["email"], text)
        server.quit()

        return jsonify({"success":True, "message": "Registration successful"}), 201
    except Exception as e:
        db.rollback()
        if type(e) == requests.exceptions.HTTPError:
            error_json = e.args[1]
            error = json.loads(error_json)['error']['message']
            if error == "EMAIL_EXISTS":
                return jsonify({"success": False, "message":"Account already exists"}), 400
            return jsonify({"success": False, "message":str(e)}), 400
        adminauth.delete_user(uid)
        return jsonify({"success": False, "message":str(e)}), 400


@app.route('/users/<string:userId>',methods=['PUT'])
@login_required
def update_single_users(user,userId):
    try:
        data = request.get_json()
        user_name = data.get('user_name')
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        uid = user['users'][0]['localId']
        if not check_permission(uid,[5,6,],userId) :
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401

        fields_to_update = []
        params = []

        if user_name:
            fields_to_update.append("user_name = ?")
            params.append(user_name)

        if not fields_to_update:
            return jsonify({"success": False,'message': 'No data provided to update'}), 400

        params.append(userId)
        update_query = f"UPDATE USER SET {', '.join(fields_to_update)} WHERE user_id = ?"
        cursor.execute(update_query, params)
        db.commit()

        if cursor.rowcount == 0:
            return jsonify({"success": False,'message': 'User not found or data not changed'}), 404
        db.close()

        return jsonify({"success": True,'message': 'User updated successfully'}), 200
    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400



@app.route('/users/<string:userId>',methods=['DELETE'])
@login_required
def delete_single_users(user,userId):
    try:
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        uid = user['users'][0]['localId']
        if not check_permission(uid,[7,]) :
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401
        
        cursor.execute("SELECT * FROM USER WHERE user_id=?", (userId,))
        if cursor.rowcount == 0:
             return jsonify({"success": False,"message":"User does't exist"}), 400

        # auth.delete_user_account()
        adminauth.delete_user(userId)
        cursor.execute("DELETE FROM USER WHERE user_id=?",(userId,))
        cursor.execute("DELETE FROM USER_ROLE WHERE user_id = ? ",(userId,))
        db.commit()
        db.close()
        return jsonify({"success": True,'message':"User Deleted" }), 200
    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400

@app.route('/users/roles',methods=['GET'])
@login_required
def get_user_role(user):
    try:
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        uid = user['users'][0]['localId']
        if not check_permission(uid,[8,]):
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401
        
        cursor.execute("SELECT * FROM ROLE")
        roles = cursor.fetchall()
        roleList = [{
            "role_id": role[0],
            "role_name": role[1],
        } for role in roles]

        db.close()
        return jsonify({"success": True,'roleList': roleList }), 200
    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400


@app.route('/users/<userId>/roles',methods=['PUT'])
@login_required
def update_user_role2(user,userId):
    try:
        data = request.get_json()
        role_id = data['role_id']
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        uid = user['users'][0]['localId']
        if not check_permission(uid,[9,]):
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401
        cursor.execute("UPDATE USER_ROLE SET role_id = ? WHERE user_id = ?",(role_id,userId,))
        
        cursor.execute("SELECT r.role_name FROM ROLE r WHERE r.role_id = ?",[role_id,])
        roleName = cursor.fetchone()[0]
        cursor.execute("UPDATE USER SET user_role = ? WHERE user_id = ?",(roleName,userId,))
        db.commit()
        db.close()
        return jsonify({"success": True,'message': "Role Updated Sucessfully"}), 200
    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400


# Profile Management Endpoints
    
@app.route('/profile',methods=['GET'])
@login_required
def get_profile(user):
    try:
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        uid = user['users'][0]['localId']
        if not check_permission(uid,[10,]) :
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401
        
        cursor.execute("SELECT * FROM USER WHERE user_id=?",(uid,))
        val = cursor.fetchone()
        db.close()
        userData = {
            "user_id": val[0],
            "email": val[1],
            "user_name": val[2],
            "user_role": val[3]
        }
        return jsonify({"success": True,'userData':userData }), 200
    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400


@app.route('/profile',methods=['PUT'])
@login_required
def update_profile(user):
    try:
        data = request.get_json()
        user_name = data.get('user_name')
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        uid = user['users'][0]['localId']
        if not check_permission(uid,[11,]) :
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401

        fields_to_update = []
        params = []

        if user_name:
            fields_to_update.append("user_name = ?")
            params.append(user_name)

        if not fields_to_update:
            return jsonify({"success": False,'message': 'No data provided to update'}), 400

        params.append(uid)
        update_query = f"UPDATE USER SET {', '.join(fields_to_update)} WHERE user_id = ?"
        cursor.execute(update_query, params)
        db.commit()

        if cursor.rowcount == 0:
            return jsonify({"success": False,'message': 'User not found or data not changed'}), 404
        db.close()

        return jsonify({"success": True,'message': 'Profile updated successfully'}), 200
    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400

# Role-Based Access Control (RBAC) Endpoints
    
@app.route('/rbac/roles', methods=['GET'])
@login_required
def get_roles(user):
    try:
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()        
        cursor.execute("SELECT * FROM ROLE")
        roles = cursor.fetchall()

        roleList = []
        for role in roles:
            role_id = role[0]
            role_name = role[1]

            cursor.execute("""
                SELECT p.permission_id, p.permission_name 
                FROM ROLE_PERMISSION rp
                JOIN PERMISSION p ON rp.permission_id = p.permission_id
                WHERE rp.role_id = ?
            """, (role_id,))
            permissions = cursor.fetchall()
            permission_list = [{"permission_id": permission[0], "permission_name": permission[1]} for permission in permissions]

            role_info = {
                "role_id": role_id,
                "role_name": role_name,
                "permissions": permission_list
            }
            roleList.append(role_info)

        db.close()
        return jsonify({"success": True, 'roleList': roleList}), 200
    except Exception as e:
        return jsonify({"success": False, 'message': str(e)}), 400


@app.route('/rbac/permissions',methods=['GET'])
@login_required
def get_permissions(user):
    try:
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()        
        cursor.execute("SELECT * FROM PERMISSION")
        permissions = cursor.fetchall()
        
        permissionsList = [{
            "permission_id": permission[0],
            "permission_name": permission[1],
        } for permission in permissions]

        db.close()
        return jsonify({"success": True,'permissionList': permissionsList }), 200
    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400


@app.route('/rbac/permissions/<roleId>', methods=['GET'])
@login_required
def get_permissions2(user, roleId):
    try:
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()        
        cursor.execute("SELECT PERMISSION.permission_id, PERMISSION.permission_name FROM PERMISSION INNER JOIN ROLE_PERMISSION ON PERMISSION.permission_id = ROLE_PERMISSION.permission_id WHERE ROLE_PERMISSION.role_id = ?", (roleId,))
        permissions = cursor.fetchall()
        
        permissionsList = [{
            "permission_id": permission[0],
            "permission_name": permission[1],
        } for permission in permissions]

        db.close()
        return jsonify({"success": True, 'permissionList': permissionsList}), 200
    except Exception as e:
        return jsonify({"success": False, 'message': str(e)}), 400



@app.route('/rbac/roles/<roleId>/permissions',methods=['PUT'])
@login_required
def assign_permission_to_role(user, roleId):
    try:
        data = request.get_json()
        permissions_list = data['permissionList']

        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        uid = user['users'][0]['localId']

        if not check_permission(uid, [12,]):
            return jsonify({"success": False,"message": "Unauthorized Access"}), 401

        cursor.execute("DELETE FROM ROLE_PERMISSION WHERE role_id = ?", (roleId,))

        for permission_id in permissions_list:
            cursor.execute("INSERT INTO ROLE_PERMISSION (role_id, permission_id) VALUES (?, ?)", (roleId, permission_id))

        db.commit()
        db.close()

        return jsonify({"success": True,'message': "Permissions updated for role"}), 200

    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400

    
@app.route('/rbac/users/<userId>/roles',methods=['PUT'])
@login_required
def update_user_role(user,userId):
    try:
        data = request.get_json()
        role_id = data['role_id']
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        uid = user['users'][0]['localId']
        if not check_permission(uid,[9,]):
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401
        cursor.execute("UPDATE USER_ROLE SET role_id = ? WHERE user_id = ?",(role_id,userId,))
        
        cursor.execute("SELECT r.role_name FROM ROLE r WHERE r.role_id = ?",[role_id,])
        roleName = cursor.fetchone()[0]
        cursor.execute("UPDATE USER SET user_role = ? WHERE user_id = ?",(roleName,userId,))
        db.commit()
        db.close()
        return jsonify({"success": True,'message': "Role Updated Sucessfully"}), 200
    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400

# Data Entry Interface

@app.route("/vehicle", methods=["GET"])
@login_required
def get_vehicles(user):
    try:
        uid = user['users'][0]['localId']
        if not check_permission(uid,[13,]):
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        cursor.execute("SELECT VEHICLE.*, STS_VEHICLE.sts_id FROM VEHICLE JOIN STS_VEHICLE ON VEHICLE.vehicle_number = STS_VEHICLE.vehicle_number")
        vehicles = cursor.fetchall()
        vehiclesList = [{
            "vehicle_number": vehicle[0],
            "vehicle_type": vehicle[1],
            "capacity" : vehicle[2],
            "fuel_cost_loaded":vehicle[3],
            "fuel_cost_unloaded":vehicle[4],
            "sts_id":vehicle[5]
        } for vehicle in vehicles]
        print(vehicles)
        return jsonify({"success": True,'vehiclesList': vehiclesList}), 200

    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400


@app.route("/vehicle", methods=["POST"])
@login_required
def add_vehicle(user):
    try:
        data = request.get_json()
        sts_id = data['sts_id']
        vehicle_number = data["vehicle_number"]
        vehicle_type = data["vehicle_type"]
        capacity = data['capacity']
        fuel_cost_loaded = data['fuel_cost_loaded']
        fuel_cost_unloaded = data["fuel_cost_unloaded"]
        uid = user['users'][0]['localId']
        if not check_permission(uid,[14,]):
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        cursor.execute("INSERT INTO VEHICLE (vehicle_number, vehicle_type, capacity,fuel_cost_loaded,fuel_cost_unloaded) VALUES(?,?,?,?,?)",(vehicle_number,vehicle_type,capacity,fuel_cost_loaded,fuel_cost_unloaded))
        cursor.execute("INSERT INTO STS_VEHICLE (sts_id,vehicle_number) VALUES (?,?)",(sts_id,vehicle_number,))
        db.commit()
        return jsonify({"success": True,'message': "Vehicle added sucessfully"}), 201

    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400


@app.route("/vehicle/<vehicleNumber>", methods=["DELETE"])
@login_required
def delete_vehicle(user,vehicleNumber):
    try:
        uid = user['users'][0]['localId']
        if not check_permission(uid,[15,]):
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        cursor.execute("DELETE FROM VEHICLE WHERE vehicle_number = ?",(vehicleNumber,))
        cursor.execute("DELETE FROM STS_VEHICLE WHERE vehicle_number = ?",(vehicleNumber,))
        db.commit()
        return jsonify({"success": True,'message': "Vehicle deleted sucessfully"}), 200

    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400


@app.route("/sts/<stsId>/<vehicleNumber>", methods=["POST"])
@login_required
def add_vehicle_to_sts(user,stsId,vehicleNumber):
    try:
        uid = user['users'][0]['localId']
        if not check_permission(uid,[24,]):
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        cursor.execute("INSERT INTO STS_VEHICLE (sts_id, vehicle_number) VALUES(?,?)",(stsId,vehicleNumber))
        db.commit()
        return jsonify({"success": True,'message': "Vehicle added to STS sucessfully"}), 201

    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400

    
@app.route("/sts/create", methods=["POST"])
@login_required
def add_sts(user):
    try:
        data = request.get_json()
        ward_no = data["ward_no"]
        sts_id = ward_no
        capacity = data["capacity"]
        latitude = data['latitude']
        longitude = data['longitude']
        manager_id = data['manager']
        uid = user['users'][0]['localId']
        print(check_permission(uid,[16,]))
        if not check_permission(uid,[16,]):
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        cursor.execute("INSERT INTO STS_MANAGER (sts_manager_id, sts_id, user_id) VALUES(?,?,?)",(str(sts_id)+manager_id,sts_id,manager_id))
        cursor.execute("INSERT INTO STS (ward_no, sts_id, capacity, latitude, longitude, sts_manager_id) VALUES(?,?,?,?,?,?)",(ward_no,sts_id,capacity,latitude,longitude, str(sts_id)+manager_id))
        db.commit()
        return jsonify({"success": True,'message': "STS added sucessfully"}), 201

    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400
    
@app.route("/sts", methods=["GET"])
@login_required
def get_sts(user):
    try:
        uid = user['users'][0]['localId']
        if not check_permission(uid,[17,]):
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        cursor.execute("SELECT s.ward_no, s.sts_id, s.latitude, s.longitude, m.user_id, s.capacity FROM STS s JOIN STS_MANAGER m ON s.sts_id = m.sts_id")
        sts = cursor.fetchall()
        print(sts)
        stsList = []
        stsList = [{
            "ward_no": st[0],
            "sts_id": st[1],
            "latitude": st[2],
            "longitude" : st[3],
            "manager":st[4],
            "capacity":st[5]
        } for st in sts]
        print(stsList)
        return jsonify({"success": True,'stsList': stsList}), 200

    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400
    
@app.route("/sts/<wardNo>", methods=["DELETE"])
@login_required
def delete_sts(user,wardNo):
    try:
        uid = user['users'][0]['localId']
        wardNo = int(wardNo)
        print(wardNo)
        print(type(wardNo))
        if not check_permission(uid,[18,]):
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        cursor.execute("DELETE FROM STS_MANAGER WHERE sts_id = ?",(wardNo,))
        cursor.execute("DELETE FROM STS WHERE ward_no = ?",(wardNo,))
        db.commit()
        return jsonify({"success": True,'message': "STS deleted sucessfully"}), 200

    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400

@app.route("/sts/<wardNo>", methods=["PUT"])
@login_required
def update_sts(user,wardNo):
    try:
        data = request.get_json()
        wardNo = int(wardNo)
        capacity = data["capacity"]
        latitude = data['latitude']
        longitude = data['longitude']
        manager_id = data['manager']
        uid = user['users'][0]['localId']
        if not check_permission(uid,[19,]):
            return jsonify({"success": False,"message":"Unauthorozied Access"}), 401
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        cursor.execute("UPDATE STS SET capacity = ?, latitude = ?, longitude = ? WHERE ward_no = ?",(capacity,latitude,longitude,wardNo,))
        cursor.execute("SELECT SM.user_id FROM STS AS S JOIN STS_MANAGER AS SM ON S.sts_id = SM.sts_id WHERE S.ward_no = ?" , (wardNo,))
        cursor.execute("UPDATE STS_MANAGER SET user_id = ? WHERE user_id= ? ",(manager_id,cursor.fetchone()[0],))
        db.commit()
        return jsonify({"success": True,'message': "STS updated sucessfully"}), 200

    except Exception as e:
        return jsonify({"success": False,'message': str(e)}), 400


@app.route("/waste/collection", methods=["POST"])
@login_required
def add_waste_collection(user):
    try:
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        data = request.get_json()
        uid = user['users'][0]['localId']
        cursor.execute("SELECT sts_id FROM STS_MANAGER WHERE user_id = ?", (uid,))
        sts_id = cursor.fetchone()
        if sts_id == None:
                return jsonify({"success": False, 'message': "User is not assigned as a Manager of any STS"}), 400
        vehicle_number = data["vehicle_number"]
        volume_waste = data["volume_waste"]
        arrival_time = data["arrival_time"]
        departure_time = data["departure_time"]
        
        
        if not check_permission(uid, [20]):
            return jsonify({"success": False, "message": "Unauthorized Access"}), 401
        
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        
        cursor.execute("INSERT INTO STS_ENTRY (sts_id, vehicle_number, volume_waste, arrival_time, departure_time) "
                       "VALUES (?, ?, ?, ?, ?)", (sts_id[0], vehicle_number, volume_waste, arrival_time, departure_time))
        
        db.commit()
        return jsonify({"success": True, 'message': "Waste collection added successfully"}), 201

    except Exception as e:
        return jsonify({"success": False, 'message': str(e)}), 400
    
# check if the user role == 1 select all data else get sts id from sts table matching the user id with manager id and select data from sts_entry table by sts_id
@app.route("/waste/collection", methods=["GET"])
@login_required
def get_waste_collection(user):
    try:
        uid = user['users'][0]['localId']
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        print("HI")
        if not check_permission(uid, [21]):
            return jsonify({"success": False, "message": "Unauthorized Access"}), 401
        cursor.execute("SELECT role_id FROM USER_ROLE WHERE user_id = ?", (uid,))
        role_id = cursor.fetchone()[0]
        print(role_id)
        if role_id == 1:
            print("here")
            cursor.execute("SELECT sts_id,vehicle_number,volume_waste,arrival_time,departure_time FROM STS_ENTRY")
        else:
            cursor.execute("SELECT sts_id FROM STS_MANAGER WHERE user_id = ?", (uid,))
            sts_id = cursor.fetchone()
            if sts_id == None:
                return jsonify({"success": False, 'message': "User is not assigned as a Manager of any STS"}), 400
            cursor.execute("SELECT sts_id,vehicle_number,volume_waste,arrival_time,departure_time FROM STS_ENTRY WHERE sts_id = ?", (sts_id[0],))
        # print(sts_id)
        stsEntry = cursor.fetchall()
        stsScheduleList = [{
            "sts_id": sts[0],
            "vehicle_number": sts[1],
            "volume_waste": sts[2],
            "arrival_time": sts[3],
            "departure_time": sts[4]
        } for sts in stsEntry]
        print(stsScheduleList)
        
        return jsonify({"success": True, "stsScheduleList": stsScheduleList}), 200

    except Exception as e:
        return jsonify({"success": False, 'message': str(e)}), 400
    


@app.route("/waste/disposal", methods=["POST"])
@login_required
def add_waste_disposal(user):
    try:
        uid = user['users'][0]['localId']
        print(uid)
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        data = request.get_json()
        cursor.execute("SELECT landfill_id FROM LANDFILL_MANAGER WHERE user_id = ?", (uid,))
            
        landfill_id = cursor.fetchone()[0]
        print(landfill_id)
        if landfill_id == None:
                return jsonify({"success": False, 'message': "User is not assigned as a Manager of any Landfill"}), 400
        vehicle_number = data["vehicle_number"]
        volume_waste = data["volume_waste"]
        arrival_time = data["arrival_time"]
        departure_time = data["departure_time"]
        
        if not check_permission(uid, [22]):
            return jsonify({"success": False, "message": "Unauthorized Access"}), 401
        
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        
        cursor.execute("INSERT INTO LANDFILL_ENTRY (landfill_id, vehicle_number, volume_waste, arrival_time, departure_time) "
                       "VALUES (?, ?, ?, ?, ?)", (landfill_id, vehicle_number, volume_waste, arrival_time, departure_time))
        
        landfill_entry_id = cursor.lastrowid
        print(landfill_entry_id)
        # add billings by the vehicle type and the volume of waste and the distance between the 
        # waste collection and waste disposal point by using the latitude and longitude of the waste collection and waste disposal point
        # using the STS entry table
        cursor.execute("SELECT sts_id FROM STS_ENTRY WHERE vehicle_number = ?", (vehicle_number,))
        # now calculate the distance between the waste collection and waste disposal point
        sts_id = cursor.fetchone()
        print(sts_id)
        cursor.execute("SELECT latitude, longitude FROM STS WHERE sts_id = ?", (sts_id[0],))
        sts_location = cursor.fetchone()
        print(landfill_id)
        cursor.execute("SELECT latitude, longitude FROM LANDFILL WHERE landfill_id = ?", (landfill_id,))
        landfill_location = cursor.fetchone()
        print(landfill_location)
        print(sts_location)
        distance = geopy.distance.distance(sts_location, landfill_location).km
        print(distance)
        cursor.execute("SELECT capacity, fuel_cost_loaded, fuel_cost_unloaded FROM VEHICLE WHERE vehicle_number = ?", (vehicle_number,))
        vehicle_data = cursor.fetchone()
        capacity = vehicle_data[0]
        fuel_cost_loaded = vehicle_data[1]
        fuel_cost_unloaded = vehicle_data[2]
        
        cost = (fuel_cost_unloaded + 3/5 * (fuel_cost_loaded-fuel_cost_unloaded)) * distance
        
        cursor.execute("INSERT INTO BILLING_SLIP (landfill_entry_id, weight_of_waste, fuel_cost) VALUES (?, ?, ?)", (landfill_entry_id, volume_waste, cost))
        
        db.commit()
        return jsonify({"success": True, 'message': "Waste disposal added and Bill generated successfully"}), 201

    except Exception as e:
        return jsonify({"success": False, 'message': str(e)}), 400
        # Calculate and store bills in billing entry table
    
    
@app.route("/billings", methods=["GET"])
@login_required
def get_waste_disposal_slip(user):
    try:
        uid = user['users'][0]['localId']
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        # if not check_permission(uid, [23]):
        #     return jsonify({"success": False, "message": "Unauthorized Access"}), 401
        cursor.execute("SELECT weight_of_waste, fuel_cost, generated_timestamp,billing_slip_id,landfill_entry_id FROM BILLING_SLIP")
        # print(sts_id)
        billing_slip_list = cursor.fetchall()
        billing_slip_list = [{
            "weight_of_waste": billing[0],
            "fuel_cost": billing[1],
            "generated_timestamp": billing[2],
            "billing_slip_id": billing[3],
            "landfill_entry_id": billing[4]
        } for billing in billing_slip_list]
        print(billing_slip_list)
        
        return jsonify({"success": True, "billingSlipList": billing_slip_list}), 200

    except Exception as e:
        return jsonify({"success": False, 'message': str(e)}), 400




@app.route("/waste/disposal", methods=["GET"])
@login_required
def get_waste_disposal(user):
    try:
        uid = user['users'][0]['localId']
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        
        if not check_permission(uid, [23]):
            return jsonify({"success": False, "message": "Unauthorized Access"}), 401
        cursor.execute("SELECT role_id FROM USER_ROLE WHERE user_id = ?", (uid,))
        role_id = cursor.fetchone()[0]
        print(role_id)
        if role_id == 1:
            print("here")
            cursor.execute("SELECT vehicle_number,volume_waste,arrival_time,departure_time FROM LANDFILL_ENTRY")
        else:
            
            cursor.execute("SELECT landfill_id FROM LANDFILL_MANAGER WHERE user_id = ?", (uid,))
            
            landfill_id = cursor.fetchone()
            if landfill_id == None:
                return jsonify({"success": False, 'message': "User is not assigned as a Manager of any Landfill"}), 400
            cursor.execute("SELECT vehicle_number,volume_waste,arrival_time,departure_time FROM LANDFILL_ENTRY WHERE landfill_id = ?", (landfill_id[0],))
        # print(sts_id)
        landfill_entry_list = cursor.fetchall()
        landfill_entry_list = [{
            "vehicle_number": landfill[0],
            "volume_waste": landfill[1],
            "arrival_time": landfill[2],
            "departure_time": landfill[3]
        } for landfill in landfill_entry_list]
        print(landfill_entry_list)
        
        return jsonify({"success": True, "landfillEntryList": landfill_entry_list}), 200

    except Exception as e:
        return jsonify({"success": False, 'message': str(e)}), 400


@app.route('/sts_vehicle', methods=['GET'])
@login_required
def get_vehicle_sts(user):
    try:
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        uid = user['users'][0]['localId']
        cursor.execute("SELECT sts_id FROM STS_MANAGER WHERE user_id =?",(uid,))
        stsId = cursor.fetchone()[0]
        cursor.execute("SELECT V.vehicle_number, V.vehicle_type, V.capacity, V.fuel_cost_loaded, V.fuel_cost_unloaded FROM STS_VEHICLE SV JOIN VEHICLE V ON SV.vehicle_number = V.vehicle_number WHERE SV.sts_id = ?",(stsId,))
        sts_vehicke_list = cursor.fetchall()
        stsVehicleList = [{
            "vehicle_number": vehicle[0],
            "vehicle_type": vehicle[1],
            "capacity": vehicle[2],
            "fuel_cost_loaded": vehicle[3],
            "fuel_cost_unloaded" : vehicle[4]
        } for vehicle in sts_vehicke_list]
        return jsonify({"success": True, "vehiclesList": stsVehicleList}), 200
    except Exception as e:
        return jsonify({"success": False, 'message': str(e)}), 400



@app.route('/stats', methods=['GET'])
@login_required
def get_stats(user):
    try:
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        uid = user['users'][0]['localId']
        cursor.execute("SELECT role_id FROM USER_ROLE WHERE user_id = ?",(uid,))
        cursor.execute("SELECT SUM(fuel_cost) FROM BILLING_SLIP WHERE generated_timestamp BETWEEN datetime('now', '-7 days') AND datetime('now')")
        weekly_bills = cursor.fetchone()[0]
        print("HI")
        cursor.execute("SELECT SUM(fuel_cost) FROM BILLING_SLIP WHERE generated_timestamp BETWEEN datetime('now', '-30 days') AND datetime('now')")
        monthly_bills = cursor.fetchone()[0]
        cursor.execute("SELECT SUM(fuel_cost) FROM BILLING_SLIP WHERE generated_timestamp BETWEEN datetime('now', '-1 days') AND datetime('now')")
        daily_bills = cursor.fetchone()[0]
        cursor.execute("SELECT SUM(volume_waste) FROM STS_ENTRY")
        total_waste_collected = cursor.fetchone()[0]
        cursor.execute("SELECT SUM(volume_waste) FROM LANDFILL_ENTRY")
        total_waste_disposed = cursor.fetchone()[0]

        cursor.execute("SELECT STS.sts_id, SUM(STS_ENTRY.volume_waste) AS total_volume_collected FROM STS LEFT JOIN STS_ENTRY ON STS.sts_id = STS_ENTRY.sts_id GROUP BY STS.sts_id")
        sts_waste_collected = cursor.fetchall()
        sts_waste_collected = [{
            "sts_id": sts[0],
            "total_volume_collected": sts[1]
        } for sts in sts_waste_collected]
        
                
        return jsonify({"success": True, "weekly_bills": weekly_bills, "monthly_bills":monthly_bills, "daily_bills":daily_bills, "total_waste_collected":total_waste_collected,"total_waste_disposed":total_waste_disposed, "sts_waste_collected":sts_waste_collected }), 200
    except Exception as e:
        return jsonify({"success": False, 'message': str(e)}), 400
    

#  Calculate the distance from all the STS to the Landfill and store it in the distance table with the STS id and Landfill id and return the distance

@app.route('/distance', methods=['GET'])
@login_required
def get_distance(user):
    try:
        db = sqlite3.connect("sqlite.db")
        cursor = db.cursor()
        cursor.execute("SELECT sts_id,latitude,longitude FROM STS")
        sts = cursor.fetchall()
        cursor.execute("SELECT latitude,longitude FROM LANDFILL")
        landfill = cursor.fetchone()
        distanceList = []
        for st in sts:
            distance = geopy.distance.distance(st[1:], landfill).km
            distanceList.append({"sts_id": st[0], "distance": distance})
        return jsonify({"success": True, "distanceList": distanceList}), 200
    except Exception as e:
        return jsonify({"success": False, 'message': str(e)}), 400
    
    




if __name__ == "__main__":
    app.run()
