import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todotask/UI/Sheets/category_sheet.dart';
import 'package:todotask/UI/home_screen.dart';
import 'package:todotask/controllers/task_controller.dart';
import 'package:todotask/models/task.dart';
import 'package:todotask/utils/colors.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DeleteTodoSheet extends StatefulWidget {
  static Future<dynamic> show(
    BuildContext context,
    Task task,
  ) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        builder: (context) {
          return DeleteTodoSheet(
            task: task,
          );
        });
  }

  Task task;
  DeleteTodoSheet({
    this.task,
    Key key,
  }) : super(key: key);

  @override
  _DeleteTodoSheetState createState() => _DeleteTodoSheetState();
}

class _DeleteTodoSheetState extends State<DeleteTodoSheet> {
  final TaskController _taskController = Get.put(TaskController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(color: kGrayColor),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 50,
                    alignment: Alignment.center,
                    child: const Text(
                      "Delete Task",
                      style: TextStyle(color: kWhiteColor, fontSize: 20),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: kWhiteColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                      width: 70,
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                          text: "Are You sure you want to delete this task ?\n",
                          style: const TextStyle(
                            height: 1.8,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                            color: kWhiteColor,
                          ),
                          children: [
                            TextSpan(
                              text: "Task Title : ${widget.task.title}",
                              style: const TextStyle(
                                fontSize: 14.3,
                                fontWeight: FontWeight.bold,
                                color: kWhiteColor,
                              ),
                            ),
                          ],
                        ),
                      )),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: () async {
                        Navigator.pop(context);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: kGrayColor,
                          ),
                          child: const Center(
                              child: Text(
                            'Cancel',
                            style: TextStyle(
                                color: kPurpleColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          )),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () async {
                        //TODO: Delete Task form DATABASE
                        await _taskController.deleteask(task: widget.task);

                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => const HomeScreen(),
                          ),
                        );

                        Fluttertoast.showToast(
                            msg: "Task deleted",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: kWhiteColor,
                            textColor: kPurpleColor,
                            fontSize: 16.0);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15.0),
                        child: Container(
                          width: 150,
                          padding: const EdgeInsets.all(20.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: kPurpleColor,
                          ),
                          child: const Center(
                              child: Text(
                            'Delete',
                            style: TextStyle(
                                color: kWhiteColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0),
                          )),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
