// import 'package:http/http.dart' as http;

// import '../constants/constants.dart';
// import '../models/models.dart';

// class UpdateUserLogic {
//   static Future<RegistGeneralResponse> updateUser(String name) async {
//     late RegistGeneralResponse data;
//     try {
//       Map<String, String> headers = {
//         'Content-Type': 'application/json',
//         "Access-Control-Allow-Origin": '*',
//         "Access-Control-Allow-Credentials": "true",
//       };
//       String body = User(email: email, password: password).toJson();

//       var resp = await http.post(
//         Uri.parse(API_LOGIN),
//         headers: headers,
//         body: body,
//       );
//       data = RegistGeneralResponse.fromJson(resp.body);
//     } catch (e) {
//       print(e);
//       data = RegistGeneralResponse(message: "", success: false);
//     }
//     return data;
//   }
// }
