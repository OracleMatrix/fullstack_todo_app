import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/app/modules/home/Profile/Models/get_user_profile_model.dart';
import 'package:fullstack_todo_app/app/modules/home/Profile/providers/delete_user_provider.dart';
import 'package:fullstack_todo_app/app/modules/home/Profile/providers/get_user_profile_provider.dart';
import 'package:fullstack_todo_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var _isLoading = false.obs;
  get isLoading => _isLoading;

  set isLoading(var value) => _isLoading = value;

  final GetUserProfileProvider _getUserProfileProvider =
      GetUserProfileProvider();

  final DeleteUserProvider _deleteUserProvider = DeleteUserProvider();

  var userData = UserProfileModel().obs;

  Future getUserProfile() async {
    try {
      _isLoading.value = true;
      final response = await _getUserProfileProvider.getUserProfile();
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
      _isLoading.value = false;
    }
  }

  Future deleteUser() async {
    try {
      _isLoading.value = true;
      final response = await _deleteUserProvider.deleteUser();
      if (response != null) {
        Get.snackbar(
          'Success',
          response,
          colorText: Colors.white,
          backgroundColor: Colors.green,
          icon: Icon(Icons.check_circle, color: Colors.white),
        );
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
    } finally {
      _isLoading.value = false;
    }
  }
}
