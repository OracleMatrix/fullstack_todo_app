import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_task_controller.dart';

class EditTaskView extends GetView<EditTaskController> {
  const EditTaskView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final arguments = Get.arguments;
    final todoId = arguments['todoId'];
    return Scaffold(
      appBar: AppBar(title: const Text('Edit TODO'), centerTitle: true),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.titleController.value,
                  decoration: InputDecoration(
                    hintText: 'Title',
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  validator: (value) {
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: controller.descriptionController.value,
                  decoration: InputDecoration(
                    hintText: 'Description',
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  validator: (value) {
                    return null;
                  },
                  maxLines: 5,
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8.0,
                  vertical: 12,
                ),
                child: Obx(
                  () => DropdownButtonFormField<String>(
                    value: controller.priority.value,
                    decoration: InputDecoration(
                      labelText: 'Priority',
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    items: const [
                      DropdownMenuItem(value: 'low', child: Text('Low')),
                      DropdownMenuItem(value: 'medium', child: Text('Medium')),
                      DropdownMenuItem(value: 'high', child: Text('High')),
                    ],
                    onChanged: (value) {
                      if (value != null) {
                        controller.priority.value = value;
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
              heroTag: 'save',
              backgroundColor: Colors.blue,
              onPressed: () {
                controller.updateTodo(todoId);
              },
              icon: Icon(Icons.save),
              label: Text('Save'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: FloatingActionButton.extended(
              heroTag: 'delete',
              backgroundColor: Colors.red,
              onPressed: () {
                controller.deleteTask(todoId);
              },
              icon: Icon(Icons.delete),
              label: Text('Delete'),
            ),
          ),
        ],
      ),
    );
  }
}
