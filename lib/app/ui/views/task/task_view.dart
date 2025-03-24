import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'task_viewmodel.dart';

class TaskView extends StackedView<TaskViewModel> {
  const TaskView({super.key});

  @override
  void onViewModelReady(TaskViewModel viewModel) {
    viewModel.getTasks();
    super.onViewModelReady(viewModel);
  }

  @override
  Widget builder(BuildContext context, TaskViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade400.withValues(alpha: 0.4),
        title: Text(
          "Task List View",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              viewModel.handelTapAddTask();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            viewModel.isInitialLoaderVisible
                ? Center(
                  child: CircularProgressIndicator(color: Colors.lightBlue),
                )
                : viewModel.taskList.isEmpty
                ? Center(
                  child: Text(
                    "No Task Found",
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                      color: Colors.grey,
                    ),
                  ),
                )
                : Expanded(
                  child: ListView.builder(
                    itemCount: viewModel.taskList.length,
                    itemBuilder: (context, index) {
                      final task = viewModel.taskList[index];
                      // Format the createdDate and updatedDate using the ViewModel function
                      String formattedCreatedDate = viewModel.formatDate(
                        task.createdDate!,
                      );
                      String formattedUpdatedDate = viewModel.formatDate(
                        task.updatedDate!,
                      );
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 10.0),
                        child: InkWell(
                          onTap: () {
                            viewModel.handleTapTaskItem(
                              viewModel.taskList[index],
                            );
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 15,
                              vertical: 15,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400.withValues(
                                alpha: 0.6,
                              ),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Stack(
                              children: [
                                // Task Details
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "${viewModel.taskList[index].taskName}",
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleLarge?.copyWith(
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Text(
                                      "Task Details: ${viewModel.taskList[index].taskDetails}",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: Colors.black54),
                                    ),
                                    Text(
                                      "Create: $formattedCreatedDate",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: Colors.black54),
                                    ),
                                    Text(
                                      "Update: $formattedUpdatedDate",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium
                                          ?.copyWith(color: Colors.black54),
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: IconButton(
                                    icon: Icon(
                                      task.isFavourite!
                                          ? Icons.star
                                          : Icons.star_border,
                                      color:
                                          task.isFavourite!
                                              ? Colors.amber.shade800
                                              : Colors.grey,
                                    ),
                                    onPressed: () {
                                      viewModel.toggleFavorite(task);
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
          ],
        ),
      ),
    );
  }

  @override
  TaskViewModel viewModelBuilder(BuildContext context) => TaskViewModel();
}
