import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:task_management_app/app/custom/custom_text_form_field.dart';
import 'package:task_management_app/app/model/task.dart';

import 'add_task_viewmodel.dart';

class AddTaskView extends StackedView<AddTaskViewModel> {
  final int? taskId;
  final Task? task;
  const AddTaskView({super.key, this.taskId, this.task});
  @override
  void onViewModelReady(AddTaskViewModel viewModel) {
    if (task != null) {
      viewModel.taskNameController.text = task!.taskName!;
      viewModel.taskDetailsController.text = task!.taskDetails!;
      viewModel.isFavourite = task!.isFavourite!;
    }
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(
    BuildContext context,
    AddTaskViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade300,
        title: Text(
          taskId == null ? "Add Task" : "Update Task",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          spacing: 16,
          children: [
            Text(
              "Task Name",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            CustomTextFormField(
              hintText: "Task Name",
              controller: viewModel.taskNameController,
            ),
            Text(
              "Task Details",
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
            ),
            CustomTextFormField(
              hintText: "Task Details",
              controller: viewModel.taskDetailsController,
              maxLine: 3,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Mark as Favourite",
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w700),
                ),
                Switch(
                  activeColor: Colors.blueAccent,
                  value: viewModel.isFavourite,
                  onChanged: viewModel.toggleFavourite,
                ),
              ],
            ),
            SizedBox(height: 16),

            GestureDetector(
              onTap:
                  viewModel.isAddTaskButtonBusy
                      ? null
                      : () async {
                        await viewModel.addOrUpdateTask(taskId: taskId);
                      },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blueAccent,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Center(
                  child: Text(
                    taskId == null ? "Add Task" : "Update Task",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  AddTaskViewModel viewModelBuilder(BuildContext context) => AddTaskViewModel();
}
