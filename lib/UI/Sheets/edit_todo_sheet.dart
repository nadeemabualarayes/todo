import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todotask/UI/Sheets/category_sheet.dart';
import 'package:todotask/utils/colors.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class EditTodoSheet extends StatefulWidget {
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
          return const EditTodoSheet();
        });
  }

  const EditTodoSheet({
    Key key,
  }) : super(key: key);

  @override
  _EditTodoSheetState createState() => _EditTodoSheetState();
}

class _EditTodoSheetState extends State<EditTodoSheet> {
  final TextEditingController _taskNameController = TextEditingController();
  final TextEditingController _taskDescriptionController =
      TextEditingController();

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
                    "Edit Task",
                    style: TextStyle(color: kWhiteColor, fontSize: 20),
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
                          'Edit',
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
