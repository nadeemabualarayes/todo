import 'package:get/get.dart';
import 'package:todotask/db/db_helper.dart';
import 'package:todotask/models/task.dart';

class TaskController extends GetxController {
  RxList taskList = <Task>[].obs;
  DBHelper dbHelper = DBHelper();

  Future<void> getTasks() async {
    final tasks = await dbHelper.query("tasks");
    taskList.assignAll(tasks.map((e) => Task.fromMap(e)).toList());
    update();
  }

  void addTask({Task task}) async {
    await dbHelper.insertTask(task);
    getTasks();
  }

  void deleteask({Task task}) async {
    await dbHelper.delete(task.id);
    getTasks();
  }

  void markTaskAsCompleted({Task task}) async {
    var value = await dbHelper.update(task.id);
    getTasks();
  }
}
