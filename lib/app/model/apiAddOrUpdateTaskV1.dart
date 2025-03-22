part of 'modelTask.dart';

class ApiAddOrUpdateTaskV1RequestBody {
  final String taskName;
  final String taskDetails;
  final bool isFavourite;
  final int? taskId;

  ApiAddOrUpdateTaskV1RequestBody({
    required this.taskName,
    required this.taskDetails,
    required this.isFavourite,
    this.taskId,
  });

  Map<String, dynamic> toJson() {
    return {
      'task_name': taskName,
      'task_details': taskDetails,
      'is_favourite': isFavourite,
      if (taskId != null) 'task_id': taskId,
    };
  }
}

Future<ApiAddOrUpdateTaskV1ResponseBody> apiAddOrUpdateTaskV1({
  required ApiAddOrUpdateTaskV1RequestBody body,
}) async {
  final response = await sendRequest.post('api/add-task', data: body.toJson());

  return ApiAddOrUpdateTaskV1ResponseBody.fromMap(response.data);
}

class ApiAddOrUpdateTaskV1ResponseBody {
  String message;
  Task task;

  ApiAddOrUpdateTaskV1ResponseBody({required this.message, required this.task});

  factory ApiAddOrUpdateTaskV1ResponseBody.fromMap(Map<String, dynamic> json) {
    return ApiAddOrUpdateTaskV1ResponseBody(
      message: json['message'],
      task: Task.fromJson(json['task']),
    );
  }
}
