import 'package:get/get.dart';
import 'package:todotask/db/db_helper.dart';
import 'package:todotask/models/task.dart';
import 'package:intl/intl.dart';

class TaskController extends GetxController {
  RxList<Task> taskList = <Task>[].obs;
  DBHelper dbHelper = DBHelper();
  RxList<Task> taskTodayList = <Task>[].obs;
  RxList<Task> taskCompleteList = <Task>[].obs;

  Future getTasks() async {
    final tasks = await dbHelper.query("tasks");
    taskList.assignAll(tasks.map((e) => Task.fromMap(e)).toList());
    //update();
    refresh();
  }

  Future getTodayTasks() async {
    final tasks = await dbHelper.query("tasks");
    taskTodayList.assignAll(tasks.map((e) => Task.fromMap(e)).toList().where(
        (element) => element.date == DateFormat.yMd().format(DateTime.now())));
    //update();
    refresh();
  }

  Future getCompleteTasks() async {
    final tasks = await dbHelper.query("tasks");
    taskCompleteList.assignAll(tasks
        .map((e) => Task.fromMap(e))
        .toList()
        .where((element) => element.isCompleted == 1));
    //update();
    refresh();
  }

  Future addTask({Task task}) async {
    await dbHelper.insertTask(task);
    getTasks();
    refresh();
  }

  Future deleteask({Task task}) async {
    await dbHelper.delete(task.id);
    getTasks();
    refresh();
  }

  Future markTaskAsCompleted({Task task, int status}) async {
    await dbHelper.update(task.id, status);
    getTasks();
    refresh();
  }
}
