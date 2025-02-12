part of 'todo_cubit.dart';

abstract class TodoState {}

class TodoInitialState extends TodoState {}

class TodoLoading extends TodoState {
  final bool loading;
  TodoLoading({required this.loading});
}

class TodoValue extends TodoState {
  final Future<List<TodoModel>> todoList;

  TodoValue({required this.todoList});
}

class TodoSucess extends TodoState {}

class TodoFailure extends TodoState {}
