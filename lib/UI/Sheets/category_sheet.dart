import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todotask/UI/create_category_page.dart';
import 'package:todotask/controllers/category_controller.dart';
import 'package:todotask/models/category.dart';
import 'package:todotask/utils/colors.dart';

class CategorySheet extends StatefulWidget {
  static Future<dynamic> show(
    BuildContext context,
  ) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(30),
          ),
        ),
        clipBehavior: Clip.hardEdge,
        builder: (context) {
          return const CategorySheet();
        });
  }

  const CategorySheet({
    Key key,
  }) : super(key: key);

  @override
  _CategorySheetState createState() => _CategorySheetState();
}

class _CategorySheetState extends State<CategorySheet> {
  // int myItems = 10;
  int lastIndex;
  final CategoryController _categoryController = Get.put(CategoryController());

  @override
  void initState() {
    _categoryController.getCategories();
    lastIndex = _categoryController.categoryList.length;
    super.initState();
  }

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
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    "Choose Category",
                    style: TextStyle(color: kWhiteColor, fontSize: 20),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Divider(
                  color: kWhiteColor,
                  thickness: 2,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GridView.builder(
                  physics: const ScrollPhysics(),
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 5.0,
                    mainAxisSpacing: 5.0,
                  ),
                  itemCount: _categoryController.categoryList.length + 1,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (index == lastIndex) {
                          // todo : open new dialog to add new category
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => const AddCategoryScreen(),
                            ),
                          );
                        } else {
                          // get index and name and icon to save it when add to database
                          print(index);
                        }
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: kPurpleColor,
                            ),
                            child: (index == lastIndex)
                                ? Icon(Icons.add)
                                : Icon(Icons.offline_bolt),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              (index == lastIndex)
                                  ? "Add Category"
                                  : _categoryController
                                      .categoryList[index].name,
                              style: const TextStyle(color: kWhiteColor),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
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
                      Fluttertoast.showToast(
                          msg: "done",
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
                          'Choose',
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
    );
  }
}
