import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/edit_task_controller.dart';

class EditTaskView extends GetView<EditTaskController> {
  const EditTaskView({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
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
            ],
          ),
        ),
      ),
    );
  }
}
