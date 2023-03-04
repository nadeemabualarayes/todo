import 'package:get/get.dart';
import 'package:todotask/db/db_helper.dart';
import 'package:todotask/models/category.dart';

class CategoryController extends GetxController {
  List<Category> categoryList = <Category>[];
  DBHelper dbHelper = DBHelper();

  Future<void> getCategories() async {
    final category = await dbHelper.query("categories");
    categoryList.assignAll(category.map((e) => Category.fromMap(e)).toList());
    update();
  }

  void addCategory({Category category}) async {
    await dbHelper.insertCategory(category);
    getCategories();
  }
}
