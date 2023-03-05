import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todotask/db/db_helper.dart';
import 'package:todotask/models/task.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:todotask/utils/colors.dart';

class TaskController extends GetxController {
  RxList<Task> taskList = <Task>[].obs;
  RxList<Task> taskTodayList = <Task>[].obs;
  RxList<Task> taskCompleteList = <Task>[].obs;
  DBHelper dbHelper = DBHelper();

  var searchText = "".obs;
  void setSearchText(String text) {
    searchText.value = text;
  }

  Future getFilterdTasks() async {
    final tasks = await dbHelper.query("tasks");
    taskList.assignAll(tasks
        .map((e) => Task.fromMap(e))
        .toList()
        .where((element) => element.title == searchText.value));
    //update();
    refresh();
  }

  Future getTasks(String value) async {
    final tasks = await dbHelper.query("tasks");
    if (value == "All" || value == "") {
      taskList.assignAll(tasks.map((e) => Task.fromMap(e)).toList());
      //update();
      refresh();
    } else if (value == "All") {
      taskList.assignAll(tasks.map((e) => Task.fromMap(e)).toList().where(
          (element) =>
              element.date == DateFormat.yMd().format(DateTime.now())));
      //update();
      refresh();
    } else if (value == "Complete") {
      taskList.assignAll(tasks
          .map((e) => Task.fromMap(e))
          .toList()
          .where((element) => element.isCompleted == 1));
      //update();
      refresh();
    }

    //update();
    refresh();
  }

  Future addTask({Task task}) async {
    await dbHelper.insertTask(task);
    getTasks("");
    refresh();
  }

  Future deleteask({Task task}) async {
    await dbHelper.delete(task.id);
    getTasks("");
    refresh();
  }

  Future markTaskAsCompleted({Task task, int status}) async {
    await dbHelper.updateTaskStatus(task.id, status);
    getTasks("");
    refresh();
  }
}

//EventCalendarDataSource get data from user and show as Calendar
class EventCalendarDataSource extends CalendarDataSource {
  EventCalendarDataSource(List<Task> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    print(appointments[index].date);
    DateFormat dateFormat = DateFormat('M/d/yyyy');
    DateTime dateTime = dateFormat.parse(appointments[index].date);
    print(dateTime);
    return dateTime;
  }

  @override
  DateTime getEndTime(int index) {
    print(appointments[index].date);
    DateFormat dateFormat = DateFormat('M/d/yyyy');
    DateTime dateTime = dateFormat.parse(appointments[index].date);
    print(dateTime);
    return dateTime;
  }

  @override
  String getSubject(int index) {
    return appointments[index].title;
  }

  @override
  Color getColor(int index) {
    return kPurpleColor;
  }
}
