import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/app/modules/home/AddTask/providers/add_task_provider.dart';
import 'package:fullstack_todo_app/app/modules/home/controllers/home_controller.dart';
import 'package:get/get.dart';

class AddTaskController extends GetxController {
  var isLoading = false.obs;

  var _addTaskProvider = AddTaskProvider();
  get addTaskProvider => _addTaskProvider;

  set addTaskProvider(var value) => _addTaskProvider = value;

  final priority = 'low'.obs;

  var titleController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;

  final HomeController _homeController = Get.find();

  Future addTask() async {
    try {
      isLoading.value = true;
      final data = {
        'title': titleController.value.text,
        'description': descriptionController.value.text,
        'priority': priority.value,
      };
      final response = await _addTaskProvider.addTask(data);
      if (response != null) {
        await _homeController.getUserData();
        Get.back();
        Get.snackbar(
          'Success',
          response['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: Icon(Icons.check, color: Colors.white),
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
