import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/app/data/Constants/consts.dart';
import 'package:fullstack_todo_app/app/modules/Authentication/providers/login_provider.dart';
import 'package:fullstack_todo_app/app/modules/Authentication/providers/register_provider.dart';
import 'package:fullstack_todo_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class AuthenticationController extends GetxController {
  var _registerProvider = RegisterProvider();
  get registerProvider => _registerProvider;

  set registerProvider(var value) => _registerProvider = value;

  var _loginProvider = LoginProvider();
  get loginProvider => _loginProvider;

  set loginProvider(var value) => _loginProvider = value;

  var isLoading = false.obs;

  Future register(String username, String email, String password) async {
    try {
      isLoading.value = true;
      final data = {'username': username, 'email': email, 'password': password};
      final response = await _registerProvider.register(data);
      if (response != null) {
        Constants.storage.write(Constants.userIdKey, response['user']['id']);
        Constants.storage.write(
          Constants.userIdKey,
          response['user']['username'],
        );
        Constants.storage.write(Constants.userIdKey, response['token']);
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: Icon(Icons.error, color: Colors.white),
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future login(String username, String password) async {
    try {
      isLoading.value = true;
      final data = {'username': username, 'password': password};
      final response = await _loginProvider.login(data);
      if (response != null) {
        Constants.storage.write(Constants.userIdKey, response['user']['id']);
        Constants.storage.write(
          Constants.userIdKey,
          response['user']['username'],
        );
        Constants.storage.write(Constants.userIdKey, response['token']);
        Get.offAllNamed(Routes.HOME);
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        backgroundColor: Colors.red,
        colorText: Colors.white,
        icon: Icon(Icons.error, color: Colors.white),
      );
    } finally {
      isLoading.value = false;
    }
  }
}
