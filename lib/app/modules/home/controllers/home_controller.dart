import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/app/modules/home/Models/get_user_data_model.dart';
import 'package:fullstack_todo_app/app/modules/home/providers/get_user_data_provider.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var isLoading = false.obs;

  var _getUserDataProvider = GetUserDataProvider();
  get getUserDataProvider => _getUserDataProvider;

  set getUserDataProvider(var value) => _getUserDataProvider = value;

  var userData = GetUserDataModel().obs;

  Future getUserData() async {
    try {
      isLoading.value = true;
      final response = await _getUserDataProvider.getUserData();
      if (response != null) {
        userData.value = response;
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

  @override
  void onInit() {
    getUserData();
    super.onInit();
  }
}
