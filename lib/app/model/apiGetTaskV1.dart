part of 'modelTask.dart';

Future<ApiGetTaskV1ResponseBody> apiGetTaskV1() async {
  final response = await sendRequest.get('api/glitch-tasks');

  return ApiGetTaskV1ResponseBody.fromMap(response.data);
}

class ApiGetTaskV1ResponseBody {
  List<Task> data;

  ApiGetTaskV1ResponseBody({required this.data});

  factory ApiGetTaskV1ResponseBody.fromMap(List<dynamic> json) {
    return ApiGetTaskV1ResponseBody(
      data: json.map((e) => Task.fromJson(e)).toList(),
    );
  }
}
