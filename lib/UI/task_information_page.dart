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
import 'package:todotask/models/task.dart';
import '../utils/colors.dart';
import 'Sheets/edit_todo_sheet.dart';

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
  @override
  void initState() {
    newTask = widget.task;
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
    _isChecked = (newTask.isCompleted == 0) ? false : true;
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
                        await _taskController.markTaskAsCompleted(
                            task: newTask, status: (_isChecked) ? 1 : 0);
                        //TODO : EDIT STATUS ON DATABASE
                      },
                      child: Container(
                        height: 30,
                        width: 160,
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
                                    : 'Mark as  Not Complete', //todo
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
                      onTap: () {
                        EditTodoSheet.show(context); //todo pass text
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
                            showTitleActions: true, onChanged: (date) {
                          print(
                              'change $date in time zone ${date.timeZoneOffset.inHours}');
                        }, onConfirm: (date) {
                          print('confirm $date');
                        }, currentTime: DateTime.now());
                      },
                      child: Container(
                        height: 30,
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
                                newTask.date, // todo:
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
                      onTap: () {
                        CategorySheet.show(context);
                      },
                      child: Container(
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.all(
                            Radius.circular(6),
                          ),
                          color: Color(
                            int.parse(_categoryController
                                .categoryList[newTask.categoryId - 1].color),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                _categoryController
                                    .categoryList[newTask.categoryId - 1].name,
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
                  // TODO: Delete task form database
                  DeleteTodoSheet.show(context);
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
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const HomeScreen(),
                      ),
                    );

                    Fluttertoast.showToast(
                        msg: "you cant",
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
