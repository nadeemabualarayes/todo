import 'package:flutter/material.dart';
import 'package:flutter_iconpicker/flutter_iconpicker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:todotask/controllers/category_controller.dart';
import 'package:todotask/models/category.dart';
import '../utils/colors.dart';

class AddCategoryScreen extends StatefulWidget {
  const AddCategoryScreen({Key key}) : super(key: key);
  static const String id = '/AddCategoryScreen';
  @override
  State<AddCategoryScreen> createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        iconTheme: const IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          "Create new category",
          style: TextStyle(color: kWhiteColor),
        ),
      ),
      body: const addCategoryWidget(),
    );
  }
}

class addCategoryWidget extends StatefulWidget {
  const addCategoryWidget({
    Key key,
  }) : super(key: key);

  @override
  State<addCategoryWidget> createState() => _addCategoryWidgetState();
}

class _addCategoryWidgetState extends State<addCategoryWidget> {
  TextEditingController name = TextEditingController();
  List<Color> colorList = [bluishClr, pinkClr, orangeClr];
  int _selectedColor = 0;
  Icon _icon;
  final CategoryController _categoryController = Get.put(CategoryController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
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
                    controller: name,
                    style: const TextStyle(color: kTextColor),
                    decoration: const InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: kTextColor),
                      ),
                      hintText: 'Category Name',
                      hintStyle: TextStyle(color: kTextColor),
                      border: OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: kTextColor),
                      ),
                    ),
                  ),
                )),
          ),
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Category Icon',
                    style: TextStyle(color: kWhiteColor),
                    textAlign: TextAlign.left,
                  ),
                ),
                // Figma Flutter Generator Frame159Widget - FRAME - HORIZONTAL
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                    onTap: () {
                      _pickIcon();
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
                            (_icon != null)
                                ? Icon(
                                    _icon.icon,
                                    color: kWhiteColor,
                                  )
                                : const Text(
                                    'Choose icon from library',
                                    textAlign: TextAlign.left,
                                    style: TextStyle(
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
          ),
          Container(
            margin:
                const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            alignment: Alignment.centerLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Category color',
                    style: TextStyle(color: kWhiteColor),
                    textAlign: TextAlign.left,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: List.generate(
                      colorList.length,
                      (index) => Padding(
                        padding: const EdgeInsets.only(right: 8.0, top: 8),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _selectedColor = index;
                              print(colorList[_selectedColor].toString());
                            });
                          },
                          borderRadius: BorderRadius.circular(50),
                          child: CircleAvatar(
                            backgroundColor: colorList[index],
                            child: index == _selectedColor
                                ? const Icon(
                                    Icons.check,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 25.0, vertical: 370),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                GestureDetector(
                  onTap: () async {
                    Navigator.pop(context);
                    _categoryController.getCategories();
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kBackgroundColor,
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
                    //TODO: ADD TO DATABASE -> COLOR AND NAME AND ICON

                    _categoryController.addCategory(
                      category: Category(
                        id: null,
                        name: name.text,
                        icon: _icon,
                        color: colorList[_selectedColor].toString(),
                      ),
                    );

                    Fluttertoast.showToast(
                        msg: "Added Successfully",
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
                      width: 200,
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kPurpleColor,
                      ),
                      child: const Center(
                          child: Text(
                        'Create Category',
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
          ),
          const SizedBox(
            height: 50,
          ),
        ],
      ),
    );
  }

  _pickIcon() async {
    IconData icon = await FlutterIconPicker.showIconPicker(context,
        iconPackModes: [IconPack.cupertino]);

    _icon = Icon(icon);
    setState(() {});
    print(_icon.icon.toString());
    debugPrint('Picked Icon:  $icon');
  }
}
