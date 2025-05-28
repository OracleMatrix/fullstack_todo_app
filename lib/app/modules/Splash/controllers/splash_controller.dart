import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/app/data/Constants/consts.dart';
import 'package:fullstack_todo_app/app/modules/Splash/providers/refresh_token_provider.dart';
import 'package:fullstack_todo_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  final RefreshTokenProvider _refreshTokenProvider = RefreshTokenProvider();

  Future checkUser() async {
    try {
      final token = await GetStorage().read(Constants.tokenKey);
      final userId = await GetStorage().read(Constants.userIdKey);
      final userName = await GetStorage().read(Constants.userNameKey);

      if (token != null && userId != null && userName != null) {
        final newToken = await _refreshTokenProvider.refreshToken();
        if (newToken != null) {
          await GetStorage().write(Constants.tokenKey, newToken['token']);
          Get.offAllNamed(Routes.HOME);
        }
      } else {
        Get.offAllNamed(Routes.AUTHENTICATION);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: Icon(Icons.error, color: Colors.white),
      );
    }
  }

  @override
  void onInit() {
    checkUser();
    super.onInit();
  }
}
