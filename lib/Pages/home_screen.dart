import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todotask/Pages/Sheets/todo_sheet.dart';

import '../utils/colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key key}) : super(key: key);
  static const String id = '/HomeScreen';
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //TodoSheet.show(context);
          var event = await TodoSheet.show(
            context,
          );
          print(event);
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
                  onTap: () async {},
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
      body:
          // Todo : when i have data the layout will be change
          const NewHomePage(),
      //const OriginalHomePage(),
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
  String dropdownValue = 'Dog';
  bool _isChecked = false;
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
                  width: 100,
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
                      });
                    },
                    items: <String>['Dog', 'Cat', 'Tiger', 'Lion']
                        .map<DropdownMenuItem<String>>((String value) {
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
          Padding(
            padding: const EdgeInsets.all(16.0),
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
                      onChanged: (value) {
                        setState(() {
                          _isChecked = value;
                          print(_isChecked);
                        });
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: const <Widget>[
                            Text(
                              'Tack out dogs',
                              style: TextStyle(
                                color: kTextColor,
                                fontSize: 16,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            Text(
                              'Today At 18:20',
                              style: TextStyle(
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
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(4),
                                topRight: Radius.circular(4),
                                bottomLeft: Radius.circular(4),
                                bottomRight: Radius.circular(4),
                              ),
                              color: Color.fromRGBO(255, 127, 127, 1),
                            ),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                // Container(
                                //     width: 14,
                                //     height: 14,
                                //     decoration: const BoxDecoration(
                                //       color: Color.fromRGBO(255, 128, 128, 1),
                                //     ),
                                //     child: SvgPicture.asset(
                                //         'assets/images/vector.svg',
                                //         semanticsLabel: 'vector')),
                                const SizedBox(width: 5),
                                const Text(
                                  'Home',
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
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
          )
        ],
      ),
    );
  }
}
