import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/app/data/Constants/consts.dart';
import 'package:fullstack_todo_app/app/modules/home/EditTask/providers/update_status_provider.dart';
import 'package:fullstack_todo_app/app/modules/home/EditTask/providers/update_todo_provider.dart';
import 'package:fullstack_todo_app/app/modules/home/controllers/home_controller.dart';
import 'package:fullstack_todo_app/app/modules/home/providers/delete_task_provider.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class EditTaskController extends GetxController {
  var isLoading = false.obs;

  var _updateTodoProvider = UpdateTodoProvider();
  get updateTodoProvider => _updateTodoProvider;

  set updateTodoProvider(var value) => _updateTodoProvider = value;

  var _deleteTaskProvider = DeleteTaskProvider();
  get deleteTaskProvider => _deleteTaskProvider;

  set deleteTaskProvider(var value) => _deleteTaskProvider = value;

  final priority = 'low'.obs;

  final status = 'pending'.obs;

  var titleController = TextEditingController().obs;
  var descriptionController = TextEditingController().obs;
  var categoryController = TextEditingController().obs;

  var _updateStatusProvider = UpdateStatusProvider();
  get updateStatusProvider => _updateStatusProvider;

  set updateStatusProvider(var value) => _updateStatusProvider = value;

  final HomeController _homeController = Get.find();

  Future updateTodo(int todoId) async {
    try {
      isLoading.value = true;
      final data = {
        'title': titleController.value.text,
        'description': descriptionController.value.text,
        'priority': priority.value,
        'category': categoryController.value.text,
        'userId': await GetStorage().read(Constants.userIdKey),
      };
      final response = await _updateTodoProvider.updateTodo(data, todoId);

      if (response != null) {
        await _homeController.getUserData();
        Get.back();
        Get.snackbar(
          'Success',
          response,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: Icon(Icons.check_circle, color: Colors.white),
        );
        await _homeController.getUserData();
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

  Future deleteTask(int todoId) async {
    try {
      isLoading.value = true;
      final response = await _deleteTaskProvider.deletetask(todoId);
      if (response != null) {
        await _homeController.getUserData();
        Get.back();
        Get.snackbar(
          'Success',
          response,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: Icon(Icons.check_circle, color: Colors.white),
        );
        await _homeController.getUserData();
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

  Future updateStatus(int todoId) async {
    try {
      isLoading.value = true;
      final data = {'status': status.value};
      if (status.value == 'completed') {
        _homeController.markAsCompleted(todoId);
        _updateStatusProvider.updateStatus(data, todoId);
      } else {
        await _updateStatusProvider.updateStatus(data, todoId);
      }
      await _homeController.getUserData();
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
