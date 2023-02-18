import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:todo_app/data/models/AuthenticatedUser.dart';
import 'package:todo_app/utils/constants.dart';

class UserService {
  static Future<AuthenticatedUser> authentication(data) async {
    log('${Constant.BASE_URL}authentication');

    var result =
        await Dio().post('${Constant.BASE_URL}authentication', data: data);
        print(result);
    log('OKayyyyyyyyyyyyyyy');
    return AuthenticatedUser.fromJson(result.data);
  }

  static Future<User> create(data) async {
    log('${Constant.BASE_URL}users');
    var response = await Dio().post('${Constant.BASE_URL}users', data: data);
    print(response);
    return User.fromJson(response.data);
  }
}
