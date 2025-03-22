import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:stacked/stacked.dart';
import 'package:task_management_app/app/model/modelTask.dart';
import 'package:task_management_app/app/model/task.dart';
import 'package:task_management_app/app/service/custom_snackbar_service.dart';
import 'package:task_management_app/app/ui/views/add_task/add_task_view.dart';

class TaskViewModel extends BaseViewModel {
  List<Task> taskList = [];
  bool get isInitialLoaderVisible => busy(getTasks);

  Future<void> getTasks() async {
    setBusyForObject(getTasks, true);
    try {
      var response = await apiGetTaskV1();

      if (response.data.isNotEmpty) {
        taskList = response.data;
      }
      notifyListeners();
    } catch (e) {
      CustomSnackbarService.error(e.toString());
    } finally {
      setBusyForObject(getTasks, false);
    }
  }

  void handelTapAddTask() async {
    // Navigate to AddTaskView and wait for a result
    final result = await Get.to(() => const AddTaskView());

    // If the result is true, refresh the task list
    if (result == true) {
      await getTasks();
    }
  }

  void handleTapTaskItem(Task task) async {
    // Navigate to AddTaskView with the selected task and wait for a result
    final result = await Get.to(
      () => AddTaskView(taskId: task.taskId, task: task),
    );

    // If the result is true, refresh the task list
    if (result == true) {
      await getTasks();
    }
  }

  /// Toggle the favorite status of a task
  Future<void> toggleFavorite(Task task) async {
    try {
      // Toggle the favorite status locally
      task.isFavourite = !task.isFavourite!;

      // Call the API to update the task's favorite status
      final requestBody = ApiAddOrUpdateTaskV1RequestBody(
        taskName: task.taskName!,
        taskDetails: task.taskDetails!,
        isFavourite: task.isFavourite!,
        taskId: task.taskId,
      );

      await apiAddOrUpdateTaskV1(body: requestBody);

      // Refresh the task list
      await getTasks();

      // Show a success message
      CustomSnackbarService.success(
        task.isFavourite!
            ? 'Task marked as favorite!'
            : 'Task unmarked as favorite!',
      );
    } catch (e) {
      // Revert the favorite status if the API call fails
      task.isFavourite = !task.isFavourite!;
      CustomSnackbarService.error('Failed to update task: $e');
    }
  }

  /// Helper function to format a DateTime
  String formatDate(DateTime dateTime) {
    return DateFormat('dd,MMMM,yyyy, hh:mm a').format(dateTime);
  }
}
