// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/app/data/Constants/consts.dart';
import 'package:fullstack_todo_app/app/routes/app_pages.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../controllers/home_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    controller.getUserData();
    return RefreshIndicator(
      onRefresh: () => controller.getUserData(),
      child: Scaffold(
        appBar: AppBar(
          actions: [
            IconButton(
              onPressed: () async {
                await GetStorage().remove(Constants.tokenKey);
                Get.offAllNamed(Routes.AUTHENTICATION);
              },
              icon: Icon(Icons.logout_rounded),
            ),
          ],
          title: const Text('T O D O'),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(Get.height * 0.07),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SearchBar(hintText: 'Search task...'),
            ),
          ),
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return Center(
              child: LoadingAnimationWidget.dotsTriangle(
                color: Colors.blue,
                size: 80,
              ),
            );
          }
          if (controller.userData.value.todos?.isEmpty ?? [].isNotEmpty) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.hourglass_empty,
                      size: 100,
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'You have no TODOs yet...!',
                    style: TextStyle(fontSize: 18),
                  ),
                ],
              ),
            );
          }
          if (controller.userData.value.todos == null) {
            return Center(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(Icons.error, size: 100, color: Colors.red),
                  ),
                  Text('No data to show...!', style: TextStyle(fontSize: 18)),
                ],
              ),
            );
          }
          return ListView.builder(
            padding: EdgeInsets.all(8),
            itemCount: controller.userData.value.todos?.length,
            itemBuilder: (context, index) {
              final todo = controller.userData.value.todos![index];

              Color priorityColor;
              switch (todo.priority?.toLowerCase()) {
                case 'high':
                  priorityColor = Colors.red;
                  break;
                case 'medium':
                  priorityColor = Colors.orange;
                  break;
                case 'low':
                  priorityColor = Colors.green;
                  break;
                default:
                  priorityColor = Colors.grey;
              }

              IconData statusIcon;
              Color statusColor;
              switch (todo.status?.toLowerCase()) {
                case 'completed':
                  statusIcon = Icons.check_circle;
                  statusColor = Colors.green;
                  break;
                case 'pending':
                  statusIcon = Icons.pending_actions;
                  statusColor = Colors.orange;
                  break;
                case 'in-progress':
                  statusIcon = Icons.hourglass_empty_rounded;
                  statusColor = Colors.blue;
                  break;
                default:
                  statusIcon = Icons.help_outline;
                  statusColor = Colors.grey;
              }

              return Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 4,
                ),
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: ListTile(
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    leading: Icon(statusIcon, color: statusColor, size: 32),
                    title: Text(
                      todo.title ?? 'No title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (todo.description != null &&
                            todo.description!.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Text(
                              todo.description!,
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[700],
                              ),
                            ),
                          ),
                        Padding(
                          padding: const EdgeInsets.only(top: 6.0),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: priorityColor.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(14),
                                ),
                                child: Text(
                                  todo.priority?.toUpperCase() ?? 'NO PRIORITY',
                                  style: TextStyle(
                                    color: priorityColor,
                                    fontWeight: FontWeight.w600,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 12),
                              if (todo.completedAt != null)
                                Text(
                                  'Completed: ${timeago.format(todo.completedAt ?? DateTime.now())}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green[700],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              if (todo.completedAt == null)
                                Text(
                                  'created: ${timeago.format(todo.createdAt ?? DateTime.now())}',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.green[700],
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, size: 16),
                    onTap:
                        () => Get.toNamed(
                          Routes.EDIT_TASK,
                          arguments: {'todoId': todo.id},
                        ),
                  ),
                ),
              );
            },
          );
        }),
        floatingActionButton: FloatingActionButton(
          onPressed: () => Get.toNamed(Routes.ADD_TASK),
          backgroundColor: Colors.blue,
          child: Icon(Icons.playlist_add_rounded),
        ),
      ),
    );
  }
}
