import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:portfolio/constants/strings.dart';
import 'package:portfolio/models/user_model.dart';

class API {
  // ignore: missing_return
  static Future<UserModel> fetchUserModelData(String username) async {
    var query_params = '?username=' + username;
    var url = HOST_ADDRESS + WEBSITE_DATA + query_params;
    try {
      final res = await http.get(url);
      print(json.decode(res.body));
      return UserModel.fromJson(json.decode(res.body));
    } catch (e) {
      print('-------------------------');
      print(e);
      print('-------------------------');
    }
  }
}
