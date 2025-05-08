import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/app/modules/home/Profile/Models/get_user_profile_model.dart';
import 'package:fullstack_todo_app/app/modules/home/Profile/providers/delete_user_provider.dart';
import 'package:fullstack_todo_app/app/modules/home/Profile/providers/get_user_profile_provider.dart';
import 'package:fullstack_todo_app/app/modules/home/Profile/providers/update_user_provider.dart';
import 'package:fullstack_todo_app/app/routes/app_pages.dart';
import 'package:get/get.dart';

class ProfileController extends GetxController {
  var _isLoading = false.obs;
  get isLoading => _isLoading;

  set isLoading(var value) => _isLoading = value;

  final GetUserProfileProvider _getUserProfileProvider =
      GetUserProfileProvider();

  final DeleteUserProvider _deleteUserProvider = DeleteUserProvider();

  final UpdateUserProvider _updateUserProvider = UpdateUserProvider();

  var userData = UserProfileModel().obs;

  var userNameController = TextEditingController().obs;
  var emailController = TextEditingController().obs;
  var passwordController = TextEditingController().obs;
  var confPasswordController = TextEditingController().obs;

  final formKey = GlobalKey<FormState>();

  Future getUserProfile() async {
    try {
      _isLoading.value = true;
      final response = await _getUserProfileProvider.getUserProfile();
      if (response != null) {
        userData.value = response;
        userNameController.value.text = response.user?.username ?? '';
        emailController.value.text = response.user?.email ?? '';
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

  Future updateUser() async {
    try {
      _isLoading.value = true;
      final data = {
        'username': userNameController.value.text,
        'email': emailController.value.text,
        'password': passwordController.value.text,
      };

      final response = await _updateUserProvider.updateUser(data);

      if (response != null) {
        Get.snackbar(
          'Success',
          response,
          colorText: Colors.white,
          backgroundColor: Colors.green,
          icon: Icon(Icons.check_circle, color: Colors.white),
        );
        await getUserProfile();
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
