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
        onSignup: (value) {
          return null;
        },
        onLogin: (value) {
          return null;
        },
        onRecoverPassword: (value) {
          return null;
        },
      ),
    );
  }
}
