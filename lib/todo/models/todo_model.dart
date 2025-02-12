import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String message;

  @HiveField(2)
  final int createdAt;

  @HiveField(3)
  final int remindAt;

  @HiveField(4)
  bool isChecked;

  TodoModel({
    required this.id,
    required this.message,
    required this.createdAt,
    this.isChecked = false,
    required this.remindAt,
  });

  factory TodoModel.fromJson(Map<String, dynamic> jsonData) {
    return TodoModel(
      id: jsonData['id'],
      message: jsonData['message'],
      createdAt: jsonData['created_at'],
      isChecked: jsonData['remind_at'],
      remindAt: jsonData['is_checked'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': message,
      'created_at': createdAt,
      'remind_at': remindAt,
      'is_checked': isChecked,
    };
  }
}
