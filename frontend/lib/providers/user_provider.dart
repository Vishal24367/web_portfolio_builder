import 'package:flutter/cupertino.dart';
import 'package:portfolio/models/user_model.dart';
import 'package:portfolio/services/api.dart';

class UserProvider extends ChangeNotifier {
  UserModel _userModel;

  UserModel get userModel => _userModel;

  set userModel(UserModel value) {
    _userModel = value;
    notifyListeners();
  }

  // ignore: always_declare_return_types
  loadUserDataModel(String username) async {
    try {
      userModel ??= await API.fetchUserModelData(username);
    } catch (e) {
      print('========');
      print(e);
    }
  }
}
