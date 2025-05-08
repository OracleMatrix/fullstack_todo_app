// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    controller.getUserProfile();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
        elevation: 4,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(16)),
        ),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final user = controller.userData.value.user;

        if (user == null) {
          return const Center(
            child: Text(
              'No user data available',
              style: TextStyle(fontSize: 18),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Center(
            child: Column(
              children: [
                Card(
                  elevation: 8,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  shadowColor: Colors.blueAccent.withOpacity(0.4),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 32,
                      horizontal: 24,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blueAccent,
                          child: Text(
                            user.username != null && user.username!.isNotEmpty
                                ? user.username![0].toUpperCase()
                                : 'U',
                            style: const TextStyle(
                              fontSize: 40,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Text(
                          user.username ?? 'N/A',
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.blueAccent,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.email, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text(
                              user.email ?? 'N/A',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        Divider(
                          color: Colors.blueAccent.withOpacity(0.3),
                          thickness: 1,
                        ),
                        const SizedBox(height: 24),
                        _buildInfoRow(
                          Icons.calendar_today,
                          'Created At',
                          user.createdAt != null
                              ? user.createdAt!.toLocal().toString().split(
                                '.',
                              )[0]
                              : 'N/A',
                        ),
                        const SizedBox(height: 16),
                        _buildInfoRow(
                          Icons.update,
                          'Updated At',
                          user.updatedAt != null
                              ? user.updatedAt!.toLocal().toString().split(
                                '.',
                              )[0]
                              : 'N/A',
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Card(
                    elevation: 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    shadowColor: Colors.blueAccent.withOpacity(0.4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            onPressed: () {
                              Get.bottomSheet(
                                isScrollControlled: true,
                                enableDrag: true,
                                Container(
                                  height: Get.height * 0.6,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(16),
                                      topRight: Radius.circular(16),
                                    ),
                                    color: Colors.grey.shade800,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Form(
                                      key: controller.formKey,
                                      autovalidateMode:
                                          AutovalidateMode.onUserInteraction,
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: SingleChildScrollView(
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Column(
                                              children: [
                                                TextFormField(
                                                  controller:
                                                      controller
                                                          .userNameController
                                                          .value,
                                                  decoration: InputDecoration(
                                                    labelText: 'Username',
                                                    prefixIcon: Icon(
                                                      Icons.person,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                  ),
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'Username is required';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                const SizedBox(height: 16),
                                                TextFormField(
                                                  controller:
                                                      controller
                                                          .emailController
                                                          .value,
                                                  decoration: InputDecoration(
                                                    labelText: 'Email',
                                                    prefixIcon: Icon(
                                                      Icons.email,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                  ),
                                                  keyboardType:
                                                      TextInputType
                                                          .emailAddress,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.trim().isEmpty) {
                                                      return 'Email is required';
                                                    }
                                                    final emailRegex = RegExp(
                                                      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                                                    );
                                                    if (!emailRegex.hasMatch(
                                                      value,
                                                    )) {
                                                      return 'Enter a valid email';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                const SizedBox(height: 16),
                                                TextFormField(
                                                  controller:
                                                      controller
                                                          .passwordController
                                                          .value,
                                                  decoration: InputDecoration(
                                                    labelText: 'Password',
                                                    prefixIcon: Icon(
                                                      Icons.lock,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                  ),
                                                  obscureText: true,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Password is required';
                                                    }
                                                    if (value.length < 6) {
                                                      return 'Password must be at least 6 characters';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                const SizedBox(height: 16),
                                                TextFormField(
                                                  controller:
                                                      controller
                                                          .confPasswordController
                                                          .value,
                                                  decoration: InputDecoration(
                                                    labelText:
                                                        'Confirm Password',
                                                    prefixIcon: Icon(
                                                      Icons.lock_outline,
                                                    ),
                                                    border: OutlineInputBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                            12,
                                                          ),
                                                    ),
                                                  ),
                                                  obscureText: true,
                                                  validator: (value) {
                                                    if (value == null ||
                                                        value.isEmpty) {
                                                      return 'Confirm password is required';
                                                    }
                                                    if (value !=
                                                        controller
                                                            .passwordController
                                                            .value
                                                            .text) {
                                                      return 'Passwords do not match';
                                                    }
                                                    return null;
                                                  },
                                                ),
                                                const SizedBox(height: 24),
                                                MaterialButton(
                                                  onPressed: () {
                                                    if (controller
                                                            .formKey
                                                            .currentState
                                                            ?.validate() ??
                                                        false) {
                                                      controller.updateUser();
                                                      Get.back();
                                                    }
                                                  },
                                                  color: Colors.blue,
                                                  textColor: Colors.white,
                                                  child: Text('Update'),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                            color: Colors.blue,
                            textColor: Colors.white,
                            child: Text('Update'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: MaterialButton(
                            onPressed: () {
                              Get.defaultDialog(
                                title: 'Delete User',
                                content: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Icon(
                                        Icons.dangerous,
                                        color: Colors.red,
                                        size: 60,
                                      ),
                                    ),
                                    Text(
                                      'Are you sure you want to delete account?\nAll of your data and TODOs will be deleted',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 18,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                    },
                                    child: Text(
                                      'NO',
                                      style: TextStyle(color: Colors.green),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed: () {
                                      Get.back();
                                      controller.deleteUser();
                                    },
                                    child: Text(
                                      'YES',
                                      style: TextStyle(color: Colors.red),
                                    ),
                                  ),
                                ],
                              );
                            },
                            color: Colors.red,
                            textColor: Colors.white,
                            child: Text('Delete'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: Colors.blueAccent),
        const SizedBox(width: 12),
        Text(
          '$label:',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 16,
            color: Colors.blueAccent,
          ),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(value, style: const TextStyle(fontSize: 16))),
      ],
    );
  }
}
