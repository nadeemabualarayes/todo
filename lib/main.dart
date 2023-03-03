import 'package:flutter/material.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'UI/splash_page.dart';

void main() {
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
    return GetMaterialApp(
      title: 'Todo',
      getPages: [
        GetPage(name: '/SplashPage', page: () => const SplashPage()),
      ],
      initialRoute: '/SplashPage',
      debugShowCheckedModeBanner: false,
      builder: (context, child) => MediaQuery(
        data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
        child: child,
      ),
    );
  }
}
