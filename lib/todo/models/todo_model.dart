import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0)
class TodoModel {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String message;

  @HiveField(2)
  final DateTime createdAt;

  @HiveField(3)
  final TimeOfDay remindAtTime;

  @HiveField(4)
  final DateTime remindAtDate;

  @HiveField(5)
  bool isChecked;

  TodoModel({
    required this.id,
    required this.message,
    required this.createdAt,
    this.isChecked = false,
    required this.remindAtDate,
    required this.remindAtTime,
  });

  factory TodoModel.fromJson(Map<String, dynamic> jsonData) {
    return TodoModel(
      id: jsonData['id'],
      message: jsonData['message'],
      createdAt: jsonData['created_at'],
      isChecked: jsonData['is_checked'],
      remindAtDate: jsonData['remind_at_date'],
      remindAtTime: jsonData['remind_at_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': message,
      'created_at': createdAt,
      'remind_at_date': remindAtDate,
      'remind_at_time': remindAtTime,
      'is_checked': isChecked,
    };
  }
}
