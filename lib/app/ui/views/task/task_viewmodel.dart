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

  /// Helper function to format a DateTime
  String formatDate(DateTime dateTime) {
    return DateFormat('dd,MMMM,yyyy, hh:mm a').format(dateTime);
  }
}
