import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:provider/provider.dart';
import 'Pages/splash_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //  print(getRandomString(30));

    return MultiProvider(
        providers: [],
        child: GetMaterialApp(
          title: 'Todo',
          getPages: [
            GetPage(name: '/SplashPage', page: () => const SplashPage()),
            // GetPage(name: '/HomeScreen', page: () => const HomeScreen()),
          ],
          initialRoute: '/SplashPage',
          debugShowCheckedModeBanner: false,
          builder: (context, child) => MediaQuery(
            data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
            child: child,
          ),
        ));
  }
}
