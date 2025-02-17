import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_todo/core/constants/color_constants.dart';
import 'package:na_todo/todo/cubit/todo_cubit.dart';
import 'package:na_todo/todo/models/todo_model.dart';
import 'package:na_todo/todo/widgets/date_time_picker.dart';

class CreateTodoWidget extends StatefulWidget {
  const CreateTodoWidget({super.key, required this.model});

  @override
  State<CreateTodoWidget> createState() => _CreateTodoWidgetState();

  final TodoModel? model;
}

class _CreateTodoWidgetState extends State<CreateTodoWidget> {
  final TextEditingController _messageTxtCtrl = TextEditingController();
  String _heading = 'Enter your TODO';
  DateTime _dateVal = DateTime.now();
  TimeOfDay _timeVal = TimeOfDay.now();
  bool _isChecked = false;

  @override
  void initState() {
    super.initState();
    _setData();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              _heading,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: _messageTxtCtrl,
              maxLines: 3,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
              ),
              style: TextStyle(
                fontSize: 16,
                color: ColorsConstants.blackColor,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'Reminder at:',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: ColorsConstants.darkGreyColor,
              ),
            ),
            DateTimePicker(
              reminderDate: _dateVal,
              reminderTime: _timeVal,
              onDateSelected: _setDate,
              onTimeSelected: _setTime,
            ),
            SizedBox(
              height: 16,
            ),
            if (widget.model != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Task Completed:',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: ColorsConstants.darkGreyColor,
                    ),
                  ),
                  Checkbox(
                      value: _isChecked,
                      onChanged: (val) {
                        setState(() {
                          _isChecked = val ?? false;
                        });
                      }),
                ],
              ),
            SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: _saveTodoData,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 164, 112, 183),
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'SUBMIT',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w800,
                        color: ColorsConstants.whiteColor,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _setData() {
    setState(() {
      if (widget.model != null) {
        _heading = "Edit your TODO";
        _messageTxtCtrl.text = widget.model!.message;
        _dateVal = widget.model!.remindAtDate;
        _timeVal = widget.model!.remindAtTime;
        _isChecked = widget.model!.isChecked;
      }
    });
  }

  _setTime(TimeOfDay val) {
    setState(() {
      _timeVal = val;
    });
  }

  _setDate(DateTime val) {
    setState(() {
      _dateVal = val;
    });
  }

  void _saveTodoData() {
    BlocProvider.of<TodoCubit>(context).saveTodo(
      date: _dateVal,
      message: _messageTxtCtrl.text,
      time: _timeVal,
    );
  }
}
