import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todotask/UI/Sheets/category_sheet.dart';
import 'package:todotask/utils/colors.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DeleteTodoSheet extends StatefulWidget {
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
          return const DeleteTodoSheet();
        });
  }

  const DeleteTodoSheet({
    Key key,
  }) : super(key: key);

  @override
  _DeleteTodoSheetState createState() => _DeleteTodoSheetState();
}

class _DeleteTodoSheetState extends State<DeleteTodoSheet> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        decoration: const BoxDecoration(color: kGrayColor),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: SafeArea(
          child: Center(
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
                      "Delete Task",
                      style: TextStyle(color: kWhiteColor, fontSize: 20),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 2,
                  color: kWhiteColor,
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Container(
                    width: 70,
                    alignment: Alignment.center,
                    child: const Text(
                      "Are You sure you want to delete this task? \nTask title : Do math homework",
                      style: TextStyle(color: kWhiteColor, fontSize: 18),
                    ),
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
                        //TODO: Delete Task form DATABASE
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
                            'Delete',
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
      ),
    );
  }
}
