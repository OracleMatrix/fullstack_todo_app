// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/app/data/Constants/consts.dart';
import 'package:fullstack_todo_app/app/modules/home/EditTask/controllers/edit_task_controller.dart';
import 'package:fullstack_todo_app/app/modules/home/Widgets/all_data_widget.dart';
import 'package:fullstack_todo_app/app/modules/home/Widgets/search_result_widget.dart';
import 'package:fullstack_todo_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final EditTaskController editTaskController = Get.put(EditTaskController());
    controller.getUserData();
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () async {
              Get.defaultDialog(
                title: 'LOGOUT',
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.warning,
                        color: Colors.yellow,
                        size: 50,
                      ),
                    ),
                    Text('Are you sure you want to logout?'),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('Cancel', style: TextStyle(color: Colors.red)),
                  ),
                  TextButton(
                    onPressed: () async {
                      Get.back();
                      await GetStorage().remove(Constants.tokenKey);
                      Get.offAllNamed(Routes.AUTHENTICATION);
                    },
                    child: Text('YES', style: TextStyle(color: Colors.green)),
                  ),
                ],
              );
            },
            icon: Icon(Icons.logout_rounded),
          ),
          IconButton(
            onPressed: () async {
              Get.toNamed(Routes.PROFILE);
            },
            icon: Icon(Icons.person),
          ),
        ],
        title: const Text('T O D O'),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.blueAccent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(Get.height * 0.07),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBar(
              hintText: 'Search task...',
              controller: controller.searchController.value,
              onChanged: (value) {
                if (value.isNotEmpty && value.length >= 2) {
                  controller.searchTodos();
                }
              },
            ),
          ),
        ),
      ),
      body: Obx(
        () => RefreshIndicator(
          onRefresh: () => controller.getUserData(),
          child:
              controller.searchController.value.text.isNotEmpty ||
                      controller.isSearching.value
                  ? showSearchResults(editTaskController, controller)
                  : showAllData(editTaskController, controller),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed(Routes.ADD_TASK),
        backgroundColor: Colors.blue,
        child: Icon(Icons.playlist_add_rounded),
      ),
    );
  }
}
