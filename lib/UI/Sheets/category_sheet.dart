import 'dart:async';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todotask/UI/create_category_page.dart';
import 'package:todotask/controllers/category_controller.dart';
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
  final CategoryController _categoryController = Get.put(CategoryController());
  IconData iconData;
  int categoryId;
  String categoryName, categoryColor, categoryIcon;
  @override
  void initState() {
    _categoryController.getCategories();
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      alignment: Alignment.center,
                      child: const Text(
                        "Choose Category",
                        style: TextStyle(color: kWhiteColor, fontSize: 20),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      navigator.pop();
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const AddCategoryScreen(),
                        ),
                      );
                    },
                    child: const Icon(
                      Icons.add,
                      color: kWhiteColor,
                      size: 30,
                    ),
                  ),
                ],
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
                  itemCount: _categoryController.categoryList.length,
                  itemBuilder: (context, index) {
                    String storedIconDataString =
                        _categoryController.categoryList[index].icon;
                    List<String> parts = storedIconDataString.split(',');
                    int iconName = int.parse(parts[0]);
                    String iconFontFamily = parts[1];
                    iconData = IconData(
                      iconName,
                      fontFamily: iconFontFamily,
                      fontPackage: null,
                      matchTextDirection: false,
                    );

                    return InkWell(
                      onTap: () {
                        categoryId = _categoryController.categoryList[index].id;
                        categoryName =
                            _categoryController.categoryList[index].name;
                        categoryColor =
                            _categoryController.categoryList[index].color;
                        categoryIcon =
                            _categoryController.categoryList[index].icon;
                        Fluttertoast.showToast(
                            msg:
                                "${_categoryController.categoryList[index].name} Category Selected",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: kWhiteColor,
                            textColor: kPurpleColor,
                            fontSize: 16.0);
                      },
                      child: Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: Color(int.parse(_categoryController
                                  .categoryList[index].color)),
                            ),
                            child: Icon(iconData),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              _categoryController.categoryList[index].name,
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
                      if (categoryId == null) {
                        Fluttertoast.showToast(
                            msg: "Please Select Category",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: kWhiteColor,
                            textColor: kPurpleColor,
                            fontSize: 16.0);
                      } else {
                        Navigator.pop(context, [
                          categoryId,
                          categoryName,
                          categoryColor,
                          categoryIcon
                        ]);
                        Fluttertoast.showToast(
                            msg: "Category Selected",
                            toastLength: Toast.LENGTH_LONG,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: kWhiteColor,
                            textColor: kPurpleColor,
                            fontSize: 16.0);
                      }
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
