import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:todotask/UI/Sheets/todo_sheet.dart';
import 'package:todotask/UI/task_information_page.dart';
import 'package:todotask/controllers/category_controller.dart';
import 'package:todotask/controllers/task_controller.dart';
import '../utils/colors.dart';
import 'calender_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  static const String id = '/HomeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TaskController _taskController = Get.put(TaskController());
  bool event;
  @override
  void initState() {
    Future.delayed(
        const Duration(
          seconds: 0,
        ), () async {
      await _taskController.getTasks();
      setState(() {
        _taskController.getTasks();
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        return Future.value(false);
      },
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            await TodoSheet.show(
              context,
            );
          },
          backgroundColor: kPurpleColor,
          child: const Icon(Icons.add),
        ),
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          iconTheme: const IconThemeData(color: Colors.black),
          elevation: 0,
          title: const Text("Home"),
          backgroundColor: Colors.transparent,
          actions: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: AspectRatio(
                  aspectRatio: 0.8,
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CalenderPage(),
                        ),
                      );
                    },
                    child: SvgPicture.asset(
                      "assets/calender.svg",
                      color: kWhiteColor,
                      width: 50,
                      height: 50,
                    ),
                  )),
            ),
          ],
        ),
        body: (_taskController.taskList.isNotEmpty)
            ?
            // Todo : when i have data the layout will be change
            const NewHomePage()
            : const OriginalHomePage(),
      ),
    );
  }
}

class OriginalHomePage extends StatelessWidget {
  const OriginalHomePage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(
            "assets/pic.png",
            width: 400,
            height: 400,
          ),
          const Text(
            'What do you want to do today?',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: kWhiteColor,
              fontSize: 20,
              fontWeight: FontWeight.normal,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Tap + to add your tasks',
              style: TextStyle(
                color: kWhiteColor,
                fontSize: 16,
                fontWeight: FontWeight.normal,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class NewHomePage extends StatefulWidget {
  const NewHomePage({
    Key key,
  }) : super(key: key);

  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {
  TextEditingController search = TextEditingController();
  String dropdownValue = 'All';
  bool _isChecked = false;
  final TaskController _taskController = Get.put(TaskController());
  final CategoryController _categoryController = Get.put(CategoryController());
  IconData iconData;
  @override
  void initState() {
    Future.delayed(
        const Duration(
          seconds: 0,
        ), () async {
      await _taskController.getTasks();
      await _categoryController.getCategories();
      setState(() {
        _taskController.getTasks();
        _categoryController.getCategories();
      });
    });

    super.initState();
  }

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
                    controller: search,
                    style: const TextStyle(color: kTextColor),
                    decoration: InputDecoration(
                      prefixIcon: const Icon(
                        Icons.search,
                        color: kTextColor,
                      ),
                      suffixIcon: IconButton(
                        icon: const Icon(
                          Icons.clear,
                          color: kTextColor,
                        ),
                        onPressed: () {
                          /* Clear the search field */
                          search.clear();
                        },
                      ),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: kTextColor),
                      ),
                      hintText: 'Search for your task...',
                      hintStyle: const TextStyle(color: kTextColor),
                      border: const OutlineInputBorder(
                        borderSide: BorderSide(width: 1, color: kTextColor),
                      ),
                    ),
                  ),
                )),
          ),
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: SizedBox(
                  height: 50,
                  width: 120,
                  child: DropdownButtonFormField(
                    decoration: const InputDecoration(
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      filled: true,
                      fillColor: kGrayColor,
                    ),
                    dropdownColor: kGrayColor,
                    value: dropdownValue,
                    style: const TextStyle(color: kWhiteColor, fontSize: 15),
                    icon: const Icon(
                      Icons.arrow_drop_down_sharp,
                      color: kWhiteColor,
                    ),
                    onChanged: (String newValue) {
                      setState(() {
                        dropdownValue = newValue;
                        // TODO:
                        print(dropdownValue);
                        if (dropdownValue == "All") {
                          _taskController.getTasks();
                          _taskController.refresh();
                        } else if (dropdownValue == "Today") {
                          _taskController.getTodayTasks();
                          _taskController.refresh();
                        } else if (dropdownValue == "Complete") {
                          _taskController.getCompleteTasks();
                          _taskController.refresh();
                        }
                      });
                    },
                    items: <String>[
                      'All',
                      'Today',
                      'Complete',
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: const TextStyle(fontSize: 15),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => SizedBox(
              height: 500,
              child: ListView.builder(
                padding: const EdgeInsets.all(16.0),
                itemBuilder: (context, index) {
                  _isChecked =
                      (_taskController.taskList[index].isCompleted == 0)
                          ? false
                          : true;
                  String storedIconDataString = _categoryController
                      .categoryList[
                          _taskController.taskList[index].categoryId - 1]
                      .icon;
                  List<String> parts = storedIconDataString.split(',');
                  int iconName = int.parse(parts[0]);
                  String iconFontFamily = parts[1];
                  iconData = IconData(
                    iconName,
                    fontFamily: iconFontFamily,
                    fontPackage: null,
                    matchTextDirection: false,
                  );
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const TaskInformationScreen(),
                        ));
                      },
                      child: Container(
                          width: double.infinity,
                          height: 70,
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(4)),
                            color: kGrayColor,
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Checkbox(
                                value: _isChecked,
                                onChanged: (value) async {
                                  setState(() {
                                    _isChecked = value;
                                  });
                                  await _taskController.markTaskAsCompleted(
                                      task: _taskController.taskList[index],
                                      status: (_isChecked) ? 1 : 0);
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: <Widget>[
                                      Text(
                                        _taskController.taskList[index].title,
                                        style: const TextStyle(
                                          color: kTextColor,
                                          fontSize: 16,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                      Text(
                                        _taskController.taskList[index].date,
                                        style: const TextStyle(
                                          color: kTextColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.normal,
                                        ),
                                      ),
                                    ]),
                              ),
                              const SizedBox(
                                width: 80,
                              ),
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: SizedBox(
                                    width: 100,
                                    height: 29,
                                    child: Container(
                                      decoration: BoxDecoration(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(4),
                                        ),
                                        color: Color(int.parse(
                                            _categoryController
                                                .categoryList[_taskController
                                                        .taskList[index]
                                                        .categoryId -
                                                    1]
                                                .color)),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 4),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Icon(iconData),
                                          const SizedBox(width: 5),
                                          Text(
                                            _categoryController
                                                .categoryList[_taskController
                                                        .taskList[index]
                                                        .categoryId -
                                                    1]
                                                .name,
                                            textAlign: TextAlign.left,
                                            style: const TextStyle(
                                              color: kWhiteColor,
                                              fontSize: 12,
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                        ],
                                      ),
                                    )),
                              ),
                            ],
                          )),
                    ),
                  );
                },
                itemCount: _taskController.taskList.length,
              ),
            ),
          )
        ],
      ),
    );
  }
}
