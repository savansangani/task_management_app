class Task {
  int? taskId;
  String? taskName;
  DateTime? createdDate;
  DateTime? updatedDate;
  String? taskDetails;
  bool? isFavourite;

  Task({
    this.taskId,
    this.taskName,
    this.createdDate,
    this.updatedDate,
    this.taskDetails,
    this.isFavourite,
  });

  factory Task.fromJson(Map<String, dynamic> json) => Task(
    taskId: json["task_id"],
    taskName: json["task_name"],
    createdDate:
        json["created_date"] == null
            ? null
            : DateTime.parse(json["created_date"]),
    updatedDate:
        json["updated_date"] == null
            ? null
            : DateTime.parse(json["updated_date"]),
    taskDetails: json["task_details"],
    isFavourite: json["is_favourite"],
  );

  Map<String, dynamic> toJson() => {
    "task_id": taskId,
    "task_name": taskName,
    "created_date": createdDate?.toIso8601String(),
    "updated_date": updatedDate?.toIso8601String(),
    "task_details": taskDetails,
    "is_favourite": isFavourite,
  };
}
