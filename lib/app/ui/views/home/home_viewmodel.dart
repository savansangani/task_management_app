import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:task_management_app/app/ui/views/task/task_view.dart';

class HomeViewModel extends BaseViewModel {
  void handelTapTaskTile() {
    Get.to(() => TaskView());
  }
}
