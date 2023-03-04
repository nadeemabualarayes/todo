import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todotask/UI/Sheets/category_sheet.dart';
import 'package:todotask/controllers/task_controller.dart';
import 'package:todotask/models/task.dart';
import 'package:todotask/utils/colors.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:intl/intl.dart';

class TodoSheet extends StatefulWidget {
  static Future<dynamic> show(
    BuildContext context,
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
          return const TodoSheet();
        });
  }

  const TodoSheet({
    Key key,
  }) : super(key: key);

  @override
  _TodoSheetState createState() => _TodoSheetState();
}

class _TodoSheetState extends State<TodoSheet> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();
  final TaskController _taskController = Get.put(TaskController());
  DateTime date;
  int categoryId;
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(color: kGrayColor),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Add Task",
                    style: TextStyle(color: kWhiteColor, fontSize: 20),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Task Name",
                    style: TextStyle(color: kWhiteColor, fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: TextField(
                        controller: _taskNameController,
                        style: const TextStyle(color: kWhiteColor),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: kWhiteColor),
                          ),
                          hintText: 'Task Name',
                          hintStyle: TextStyle(color: kWhiteColor),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: kWhiteColor),
                          ),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    "Description",
                    style: TextStyle(color: kWhiteColor, fontSize: 15),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Container(
                    width: double.infinity,
                    height: 60,
                    decoration: BoxDecoration(
                        color: kBackgroundColor,
                        borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: TextField(
                        controller: _taskDescriptionController,
                        style: const TextStyle(color: kWhiteColor),
                        decoration: const InputDecoration(
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: kWhiteColor),
                          ),
                          hintText: 'Task Description',
                          hintStyle: TextStyle(color: kWhiteColor),
                          border: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: kWhiteColor),
                          ),
                        ),
                      ),
                    )),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AspectRatio(
                                aspectRatio: 0.8,
                                child: GestureDetector(
                                  onTap: () async {
                                    DatePicker.showDateTimePicker(context,
                                        theme: const DatePickerTheme(
                                          backgroundColor: kGrayColor,
                                          headerColor: kGrayColor,
                                          itemStyle: TextStyle(
                                            color: kWhiteColor,
                                            fontSize: 18,
                                          ),
                                          cancelStyle: TextStyle(
                                            color: kWhiteColor,
                                            fontSize: 16,
                                          ),
                                          doneStyle: TextStyle(
                                            color: kWhiteColor,
                                            fontSize: 16,
                                          ),
                                        ),
                                        showTitleActions: true,
                                        onChanged: (datee) {
                                      date = datee;
                                      print(
                                          'change $date in time zone ${date.timeZoneOffset.inHours}');
                                    }, onConfirm: (datee) {
                                      date = datee;
                                      print('confirm $date');
                                    }, currentTime: DateTime.now());
                                  },
                                  child: SvgPicture.asset(
                                    "assets/timer.svg",
                                    color: kWhiteColor,
                                    width: 30,
                                    height: 30,
                                  ),
                                )),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AspectRatio(
                                aspectRatio: 0.8,
                                child: GestureDetector(
                                  onTap: () async {
                                    categoryId = await CategorySheet.show(
                                      context,
                                    );
                                    if (categoryId == null) {
                                      Fluttertoast.showToast(
                                          msg: "Please Select Category",
                                          toastLength: Toast.LENGTH_LONG,
                                          gravity: ToastGravity.BOTTOM,
                                          timeInSecForIosWeb: 1,
                                          backgroundColor: kWhiteColor,
                                          textColor: kPurpleColor,
                                          fontSize: 16.0);
                                    }
                                    print(categoryId);
                                  },
                                  child: SvgPicture.asset(
                                    "assets/tag.svg",
                                    color: kWhiteColor,
                                    width: 50,
                                    height: 50,
                                  ),
                                )),
                          ),
                        ],
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: AspectRatio(
                                aspectRatio: 0.8,
                                child: GestureDetector(
                                  onTap: () async {
                                    _taskController.addTask(
                                      task: Task(
                                        id: null,
                                        title: _taskNameController.text,
                                        note: _taskDescriptionController.text,
                                        isCompleted: 0,
                                        date: DateFormat.yMd().format(date),
                                        //todo : add categoryId
                                      ),
                                    );
                                  },
                                  child: SvgPicture.asset(
                                    "assets/send.svg",
                                    color: kWhiteColor,
                                    width: 30,
                                    height: 30,
                                  ),
                                )),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
