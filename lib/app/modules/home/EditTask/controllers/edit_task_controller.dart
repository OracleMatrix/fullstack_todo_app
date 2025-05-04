import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/app/data/Constants/consts.dart';
import 'package:fullstack_todo_app/app/modules/home/EditTask/providers/update_todo_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditTaskController extends GetxController {
  var isLoading = false.obs;

  var _updateTodoProvider = UpdateTodoProvider();
  get updateTodoProvider => _updateTodoProvider;

  set updateTodoProvider(var value) => _updateTodoProvider = value;

  final priority = 'low'.obs;

  var titleController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;

  Future updateTodo(int todoId) async {
    try {
      isLoading.value = true;
      final data = {
        'title': titleController.value.text,
        'description': descriptionController.value.text,
        'priority': priority.value,
        'userId': await GetStorage().read(Constants.userIdKey),
      };
      final response = await _updateTodoProvider.updateTodo(data, todoId);

      if (response != null) {
        Get.back();
        Get.snackbar(
          'Success',
          response,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: Icon(Icons.check_circle, color: Colors.white),
        );
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
