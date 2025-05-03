import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';

import 'package:get/get.dart';

import '../controllers/authentication_controller.dart';

class AuthenticationView extends GetView<AuthenticationController> {
  const AuthenticationView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FlutterLogin(
        additionalSignupFields: [
          UserFormField(
            keyName: 'username',
            displayName: 'username',
            icon: Icon(Icons.person),
            userType: LoginUserType.name,
          ),
        ],
        onSignup: (value) {
          final result = controller.register(
            value.additionalSignupData!['username'] ?? '',
            value.name!,
            value.password!,
          );
          return result;
        },
        onLogin: (value) {
          final result = controller.login(value.name, value.password);
          return result;
        },
        onRecoverPassword: (value) {
          return null;
        },
      ),
    );
  }
}
