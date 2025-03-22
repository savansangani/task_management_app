import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey.shade400.withValues(alpha: 0.4),
        title: Text(
          "Home View",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          children: [
            ListTile(
              onTap: () => viewModel.handelTapTaskTile(),
              title: Text(
                "Tasks",
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                ),
              ),
              tileColor: Colors.grey.shade400.withValues(alpha: 0.6),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
