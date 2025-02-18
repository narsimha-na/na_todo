import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:na_todo/core/constants/color_constants.dart';
import 'package:na_todo/core/constants/image_constants.dart';
import 'package:na_todo/todo/cubit/todo_cubit.dart';
import 'package:na_todo/todo/models/todo_model.dart';
import 'package:na_todo/todo/widgets/create_todo_widget.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({super.key});

  @override
  State<TodoPage> createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TodoCubit>(context).getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorsConstants.greyColor,
      body: BlocConsumer<TodoCubit, TodoState>(listener: (context, state) {
        log("cubit state : $state");
        if (state is TodoFailure) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(state.message)));
        }
      }, builder: (context, state) {
        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(left: 26, top: 56),
              child: Text(
                'NA Todo List',
                style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
              ),
            ),
            ..._mainBody(context: context, state: state)
          ],
        );
      }),
    );
  }

  _loading() {
    return [
      CircularProgressIndicator(
        color: ColorsConstants.primaryColor,
      ),
    ];
  }

  _mainBody({required BuildContext context, required TodoState state}) {
    if (state is TodoValue) {
      List<TodoModel> list = state.todoList;
      if (list.isEmpty) {
        return _emptyList();
      } else {
        return [
          ListView.builder(
            padding: EdgeInsets.fromLTRB(16, 122, 16, 70),
            shrinkWrap: true,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return _listItem(list[index]);
            },
          ),
          _addTodoButton(context: context),
        ];
      }
    } else {
      return _loading();
    }
  }

  _listItem(TodoModel model) {
    return Container(
      padding: EdgeInsets.all(20),
      margin: EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: ColorsConstants.whiteColor,
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Row(
        children: [
          Column(
            children: [
              Text('25'),
              Text('Jan'),
            ],
          ),
          SizedBox(width: 20),
          Expanded(
            child: Text(
                'Janlooerammmmispsumhaiving datadafdasjdfasdljkapewiomfamdhuiopoimehakdfklj'),
          ),
          SizedBox(width: 20),
          Checkbox(value: true, onChanged: (val) {}),
        ],
      ),
    );
  }

  _emptyList() {
    return [
      Align(
        alignment: Alignment.center,
        child: Column(
          children: [
            Image.asset(ImgConstants.emptyImg),
            SizedBox(width: 20),
            Text('No Todo'),
          ],
        ),
      ),
      _addTodoButton(context: context),
    ];
  }

  _addTodoButton({
    required BuildContext context,
  }) {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 0, 26, 26),
        child: FloatingActionButton(
          onPressed: () {
            showBottomSheet(
                context: context,
                showDragHandle: true,
                builder: (context) {
                  return CreateTodoWidget(
                    model: null,
                  );
                });
          },
          child: Icon(Icons.add_rounded),
        ),
      ),
    );
  }
}
