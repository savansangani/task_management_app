import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:task_management_app/app/model/modelTask.dart';
import 'package:task_management_app/app/service/custom_snackbar_service.dart';

class AddTaskViewModel extends BaseViewModel {
  final TextEditingController taskNameController = TextEditingController();
  final TextEditingController taskDetailsController = TextEditingController();

  bool isFavourite = false;
  bool get isAddTaskButtonBusy => busy(addOrUpdateTask);

  void toggleFavourite(bool value) {
    isFavourite = value;
    notifyListeners();
  }

  Future<void> addOrUpdateTask({int? taskId}) async {
    // Validate fields
    if (taskNameController.text.isEmpty || taskDetailsController.text.isEmpty) {
      CustomSnackbarService.error('Please fill in all fields.');
      return;
    }

    setBusyForObject(addOrUpdateTask, true);
    try {
      // Create the request body
      final requestBody = ApiAddOrUpdateTaskV1RequestBody(
        taskName: taskNameController.text,
        taskDetails: taskDetailsController.text,
        isFavourite: isFavourite,
        taskId: taskId, // Include taskId if updating an existing task
      );

      // Call the API
      await apiAddOrUpdateTaskV1(body: requestBody);

      Get.back(result: true); // Pass true to indicate success
      // Show success message
      CustomSnackbarService.success(
        taskId == null
            ? 'Task added successfully!'
            : 'Task updated successfully!',
      );

      // Navigate back to the previous screen with a result
    } catch (e) {
      CustomSnackbarService.error('Failed to add/update task: $e');
    } finally {
      setBusyForObject(addOrUpdateTask, false);
    }
  }

  @override
  void dispose() {
    taskNameController.dispose();
    taskDetailsController.dispose();
    super.dispose();
  }
}
