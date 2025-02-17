part of 'todo_cubit.dart';

abstract class TodoState {}

class TodoInitialState extends TodoState {}

class TodoLoading extends TodoState {
  final bool loading;
  TodoLoading({required this.loading});
}

class TodoValue extends TodoState {
  final List<TodoModel> todoList;

  TodoValue({required this.todoList});
}

class TodoSucess extends TodoState {
  String message;

  TodoSucess({required this.message});
}

class TodoFailure extends TodoState {
  String message;

  TodoFailure({required this.message});
}
