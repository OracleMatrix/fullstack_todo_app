import 'package:flutter/material.dart';
import 'package:fullstack_todo_app/app/modules/home/EditTask/controllers/edit_task_controller.dart';
import 'package:fullstack_todo_app/app/modules/home/controllers/home_controller.dart';
import 'package:fullstack_todo_app/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart'
    show LoadingAnimationWidget;
import 'package:timeago/timeago.dart' as timeago show format;

Obx showAllData(
  EditTaskController editTaskController,
  HomeController controller,
) {
  return Obx(() {
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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.asset(
            'assets/images/notes.png',
            height: Get.height * 0.18,
            width: Get.width,
          ),
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
      physics: AlwaysScrollableScrollPhysics(),
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

        return Dismissible(
          key: Key(todo.id.toString()),
          background: Container(
            color: Colors.green,
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Icon(Icons.check, color: Colors.white),
                SizedBox(width: 8),
                Text('Mark as Done', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            alignment: Alignment.centerRight,
            padding: EdgeInsets.only(right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Icon(Icons.delete, color: Colors.white),
                SizedBox(width: 8),
                Text('Delete', style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
          confirmDismiss: (direction) async {
            if (direction == DismissDirection.startToEnd) {
              // Swipe left to right: mark as done
              Get.defaultDialog(
                title: 'Confirmation',
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 60,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Are you sure you want to mark this task as complete?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back();
                    },
                    child: Text('NO', style: TextStyle(color: Colors.red)),
                  ),
                  TextButton(
                    onPressed: () async {
                      Get.back();
                      await controller.markAsCompleted(todo.id!);
                    },
                    child: Text('YES', style: TextStyle(color: Colors.green)),
                  ),
                ],
              );
            } else if (direction == DismissDirection.endToStart) {
              // Swipe right to left: delete
              final confirm = await Get.defaultDialog<bool>(
                title: 'Confirmation',
                content: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(Icons.delete, color: Colors.red, size: 60),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        'Are you sure you want to delete this task?',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Get.back(result: false);
                    },
                    child: Text('NO', style: TextStyle(color: Colors.red)),
                  ),
                  TextButton(
                    onPressed: () async {
                      Get.back(result: true);
                    },
                    child: Text('YES', style: TextStyle(color: Colors.green)),
                  ),
                ],
              );

              if (confirm == true) {
                await editTaskController.deleteTask(todo.id!);
                return true; // allow dismiss animation to remove item
              } else {
                return false;
              }
            }
            return false;
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
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
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      todo.title ?? 'No title',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 4),
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: Colors.blueAccent,
                      ),
                      child: Text(
                        todo.category ?? 'No category',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                    ),
                  ],
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
                          style: TextStyle(fontSize: 14),
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
                      arguments: {'todoId': todo.id, 'data': todo},
                    ),
              ),
            ),
          ),
        );
      },
    );
  });
}
