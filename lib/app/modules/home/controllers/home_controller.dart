import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/app/modules/home/Models/get_todos_model.dart';
import 'package:fullstack_todo_app/app/modules/home/Models/get_user_data_model.dart';
import 'package:fullstack_todo_app/app/modules/home/providers/get_user_data_provider.dart';
import 'package:fullstack_todo_app/app/modules/home/providers/mark_as_done_provider.dart';
import 'package:fullstack_todo_app/app/modules/home/providers/search_provider.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  // VARIABLES
  var isLoading = false.obs;
  var isSearching = false.obs;

  var searchController = TextEditingController().obs;

  // PROVIDERS
  var _getUserDataProvider = GetUserDataProvider();

  get getUserDataProvider => _getUserDataProvider;

  set getUserDataProvider(var value) => _getUserDataProvider = value;

  var _markAsCompletedProvider = MarkAsDoneProvider();

  get markAsCompletedProvider => _markAsCompletedProvider;

  set markAsCompletedProvider(var value) => _markAsCompletedProvider = value;

  var _searchTodosProvider = SearchProvider();

  get searchTodosProvider => _searchTodosProvider;

  set searchTodosProvider(value) {
    _searchTodosProvider = value;
  }

  // MODELS
  var userData = GetUserDataModel().obs;
  var todosData = <GetTodosModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    searchController.value.addListener(() {
      if (searchController.value.text.isEmpty && isSearching.value) {
        isSearching.value = false;
        todosData.clear();
      }
    });
  }

  // FUNCTIONS
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

  Future markAsCompleted(int todoId) async {
    try {
      isLoading.value = true;
      final response = await _markAsCompletedProvider.markAsCompleted(todoId);
      if (response != null) {
        Get.snackbar(
          'Success',
          response['message'],
          backgroundColor: Colors.green,
          colorText: Colors.white,
          icon: Icon(Icons.check, color: Colors.white),
        );
        await getUserData();
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

  Future searchTodos() async {
    final query = searchController.value.text.trim();
    if (query.isEmpty) {
      // Clear search
      isSearching.value = false;
      todosData.clear();
      return;
    }

    try {
      isLoading.value = true;
      final response = await _searchTodosProvider.searchTodos(query);
      if (response != null) {
        todosData.assignAll(response);
        isSearching.value = true;
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
