import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_management_app/app/ui/views/home/home_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Task Mangement App',
      debugShowCheckedModeBanner: false,
      home: HomeView(),
    );
  }
}
