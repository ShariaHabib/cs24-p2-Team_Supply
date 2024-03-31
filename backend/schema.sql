

-- -- here
-- -- CREATE TABLE USER (
-- --     user_id VARCHAR PRIMARY KEY,
-- --     email VARCHAR,
-- --     user_name VARCHAR,
-- --     user_role VARCHAR
-- -- );

-- -- CREATE TABLE ROLE (
-- --     role_id INTEGER PRIMARY KEY,
-- --     role_name VARCHAR
-- -- );

-- -- CREATE TABLE USER_ROLE (
-- --     user_id VARCHAR,
-- --     role_id INTEGER,
-- --     FOREIGN KEY (user_id) REFERENCES USER(user_id),
-- --     FOREIGN KEY (role_id) REFERENCES ROLE(role_id),
-- --     PRIMARY KEY (user_id, role_id)
-- -- );

-- -- CREATE TABLE PERMISSION (
-- --     permission_id INTEGER PRIMARY KEY,
-- --     permission_name VARCHAR
-- -- );

-- -- CREATE TABLE ROLE_PERMISSION (
-- --     role_id INTEGER,
-- --     permission_id INTEGER,
-- --     FOREIGN KEY (role_id) REFERENCES ROLE(role_id),
-- --     FOREIGN KEY (permission_id) REFERENCES PERMISSION(permission_id),
-- --     PRIMARY KEY (role_id, permission_id)
-- -- );

-- -- CREATE TABLE VEHICLE (
-- --     vehicle_number VARCHAR PRIMARY KEY,
-- --     vehicle_type VARCHAR,
-- --     capacity INTEGER,
-- --     fuel_cost_loaded INTEGER,
-- --     fuel_cost_unloaded INTEGER
-- -- );

-- CREATE TABLE STS (
--     sts_id INT PRIMARY KEY,
--     ward_no INT,
--     latitude DOUBLE,
--     longitude DOUBLE,
--     sts_manager_id VARCHAR,
--     capacity INT,
--     FOREIGN KEY (sts_manager_id) REFERENCES STS_MANAGER(sts_manager_id)
-- );

-- CREATE TABLE STS_MANAGER (
--     sts_manager_id VARCHAR PRIMARY KEY,
--     sts_id INT,
--     user_id VARCHAR UNIQUE,
--     FOREIGN KEY (sts_id) REFERENCES STS(sts_id),
--     FOREIGN KEY (user_id) REFERENCES USER(user_id)
-- );

-- -- CREATE TABLE STS_VEHICLE (
-- --     sts_id INT,
-- --     vehicle_number VARCHAR,
-- --     FOREIGN KEY (sts_id) REFERENCES STS(sts_id),
-- --     FOREIGN KEY (vehicle_number) REFERENCES VEHICLE(vehicle_number),
-- --     PRIMARY KEY (sts_id, vehicle_number)
-- -- );
-- DROP TABLE IF EXISTS STS_ENTRY;
-- CREATE TABLE STS_ENTRY (
--     sts_entry_id INTEGER PRIMARY KEY AUTOINCREMENT,
--     sts_id INT,
--     vehicle_number VARCHAR,
--     volume_waste INT,
--     arrival_time TIMESTAMP,
--     departure_time TIMESTAMP,
--     FOREIGN KEY (sts_id) REFERENCES STS(sts_id),
--     FOREIGN KEY (vehicle_number) REFERENCES VEHICLE(vehicle_number)
-- );

-- -- CREATE TABLE LANDFILL (
-- --     landfill_id VARCHAR PRIMARY KEY,
-- --     latitude DOUBLE,
-- --     longitude DOUBLE,
-- --     capacity INTEGER,
-- --     operational_timespan VARCHAR
-- -- );

-- -- CREATE TABLE LANDFILL_MANAGER (
-- --     landfill_manager_id VARCHAR PRIMARY KEY,
-- --     landfill_id VARCHAR,
-- --     user_id VARCHAR,
-- --     FOREIGN KEY (landfill_id) REFERENCES LANDFILL(landfill_id),
-- --     FOREIGN KEY (user_id) REFERENCES USER(user_id)
-- -- );

-- CREATE TABLE LANDFILL_ENTRY (
--     landfill_entry_id INTEGER PRIMARY KEY AUTOINCREMENT,
--     landfill_id VARCHAR,
--     vehicle_number VARCHAR,
--     volume_waste INT,
--     arrival_time TIMESTAMP,
--     departure_time TIMESTAMP,
--     FOREIGN KEY (landfill_id) REFERENCES LANDFILL(landfill_id),
--     FOREIGN KEY (vehicle_number) REFERENCES VEHICLE(vehicle_number)
-- );

-- CREATE TABLE BILLING_SLIP (
--     billing_slip_id INTEGER PRIMARY KEY AUTOINCREMENT,
--     landfill_entry_id INT,
--     weight_of_waste INT,
--     fuel_cost DOUBLE,
--     generated_timestamp TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
--     FOREIGN KEY (landfill_entry_id) REFERENCES LANDFILL_ENTRY(landfill_entry_id)
-- );

-- CREATE TABLE BILLING_ENTRY (
--     BILLING_ENTRY_ID INTEGER PRIMARY KEY AUTOINCREMENT,
--     VEHICLE_NUMBER VARCHAR,
--     VOLUME_WASTE INT,
--     DISTANCE DOUBLE,
--     FUEL_COST DOUBLE
-- );