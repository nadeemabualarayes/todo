import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todotask/UI/Sheets/category_sheet.dart';
import 'package:todotask/UI/Sheets/delete_todo_sheet.dart';
import 'package:todotask/UI/home_screen.dart';
import 'package:todotask/controllers/category_controller.dart';
import 'package:todotask/controllers/task_controller.dart';
import 'package:todotask/models/category.dart';
import 'package:todotask/models/task.dart';
import '../utils/colors.dart';
import 'Sheets/edit_todo_sheet.dart';
import 'package:intl/intl.dart';

class TaskInformationScreen extends StatefulWidget {
  final Task task;

  const TaskInformationScreen({Key key, this.task}) : super(key: key);
  static const String id = '/TaskInformationScreen';
  @override
  State<TaskInformationScreen> createState() => _TaskInformationScreenState();
}

class _TaskInformationScreenState extends State<TaskInformationScreen> {
  final TaskController _taskController = Get.put(TaskController());
  final CategoryController _categoryController = Get.put(CategoryController());
  IconData iconData;
  bool _isChecked = false;

  Task newTask;
  String categoryName, categoryColor, categoryIcon;
  var event;
  @override
  void initState() {
    newTask = widget.task;
    _isChecked = (newTask.isCompleted == 0) ? false : true;
    Future.delayed(
        const Duration(
          seconds: 0,
        ), () async {
      await _taskController.getTasks("");
      await _categoryController.getCategories();
      setState(() {
        _taskController.getTasks("");
        _categoryController.getCategories();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String storedIconDataString =
        _categoryController.categoryList[newTask.categoryId - 1].icon;
    List<String> parts = storedIconDataString.split(',');
    int iconName = int.parse(parts[0]);
    String iconFontFamily = parts[1];
    iconData = IconData(
      iconName,
      fontFamily: iconFontFamily,
      fontPackage: null,
      matchTextDirection: false,
    );
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        height: 30,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                          color: kGrayColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: const <Widget>[
                              Text(
                                'X',
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        // if (newTask.isCompleted == 0) {
                        //   setState(() {
                        //     _isChecked = false;
                        //   });
                        // }
                        // if (newTask.isCompleted == 1) {
                        //   setState(() {
                        //     _isChecked = true;
                        //   });
                        // }
                        setState(() {
                          _isChecked = !_isChecked;
                        });
                        print(_isChecked);
                      },
                      child: Container(
                        height: 30,
                        width: 180,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                          color: kGrayColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                (!_isChecked)
                                    ? 'Mark as Complete'
                                    : 'Mark as Not Complete', //todo
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          newTask.title,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: kWhiteColor,
                            fontSize: 20,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          newTask.note,
                          textAlign: TextAlign.start,
                          style: const TextStyle(
                            color: kWhiteColor,
                            fontSize: 18,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    GestureDetector(
                      onTap: () async {
                        var event = await EditTodoSheet.show(context,
                            newTask.title, newTask.note); //todo pass text
                        if (event != null) {
                          setState(() {
                            newTask.title = event[0];
                            newTask.note = event[1];
                          });
                        }
                        print(event);
                      },
                      child: SvgPicture.asset(
                        "assets/edit.svg",
                        color: kWhiteColor,
                        width: 30,
                        height: 30,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {},
                        child: SvgPicture.asset(
                          "assets/timer.svg",
                          color: kWhiteColor,
                          width: 30,
                          height: 30,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Task Time :",
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
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
                            onChanged: (date) {}, onConfirm: (date) {
                          setState(() {
                            newTask.date = DateFormat.yMd().format(date);
                          });
                        }, currentTime: DateTime.now());
                      },
                      child: Container(
                        height: 40,
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.all(
                            Radius.circular(6),
                          ),
                          color: kGrayColor,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                newTask.date,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      SvgPicture.asset(
                        "assets/tag.svg",
                        color: kWhiteColor,
                        width: 30,
                        height: 30,
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Task Category :",
                            style: TextStyle(
                              color: kWhiteColor,
                              fontSize: 15,
                              fontWeight: FontWeight.normal,
                            )),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () async {
                        event = await CategorySheet.show(
                          context,
                        );
                        if (event != null) {
                          print(event);
                          newTask.categoryId = event[0];
                          categoryName = event[1];
                          categoryColor = event[2];
                          categoryIcon = event[3];

                          String storedIconDataString = categoryIcon;
                          List<String> parts = storedIconDataString.split(',');
                          int iconName = int.parse(parts[0]);
                          String iconFontFamily = parts[1];
                          iconData = IconData(
                            iconName,
                            fontFamily: iconFontFamily,
                            fontPackage: null,
                            matchTextDirection: false,
                          );
                          setState(() {});
                        }
                      },
                      child: Container(
                        height: 40,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                          color: (categoryColor != null)
                              ? Color(
                                  int.parse(categoryColor),
                                )
                              : Color(
                                  int.parse(_categoryController
                                      .categoryList[newTask.categoryId - 1]
                                      .color),
                                ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Icon(iconData),
                              const SizedBox(width: 5),
                              Text(
                                (categoryName != null)
                                    ? categoryName
                                    : _categoryController
                                        .categoryList[newTask.categoryId - 1]
                                        .name,
                                textAlign: TextAlign.left,
                                style: const TextStyle(
                                  color: kWhiteColor,
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              InkWell(
                onTap: () {
                  DeleteTodoSheet.show(context, newTask);
                },
                child: Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    SvgPicture.asset(
                      "assets/trash.svg",
                      color: kErrorColor,
                      width: 30,
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text("Delete Task",
                          style: TextStyle(
                            color: kErrorColor,
                            fontSize: 15,
                            fontWeight: FontWeight.normal,
                          )),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 50.0,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () async {
                    await _taskController.updateTaskInformation(
                      task: Task(
                          id: newTask.id,
                          title: newTask.title,
                          note: newTask.note,
                          isCompleted: (_isChecked) ? 1 : 0,
                          date: newTask.date,
                          categoryId: newTask.categoryId),
                    );

                    await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                    );

                    Fluttertoast.showToast(
                        msg: "Task Information Updated",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: kWhiteColor,
                        textColor: kPurpleColor,
                        fontSize: 16.0);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kPurpleColor,
                      ),
                      child: const Center(
                          child: Text(
                        'Edit Task',
                        style: TextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      )),
                    ),
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
