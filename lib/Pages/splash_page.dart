import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todotask/Pages/biometric_page.dart';
import 'package:todotask/utils/colors.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key key}) : super(key: key);
  static const String id = '/';
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {
  AnimationController _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    precachePicture(
        SvgPicture.asset("assets/logo.svg").pictureProvider, context);
  }

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    _controller = AnimationController(vsync: this);
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        _onAnimationCompleted(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: kBackgroundColor,
        ),
        child: Center(
            child: SvgPicture.asset(
          "assets/logo.svg",
          color: kRedColor,
          width: 100,
          height: 100,
        )),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  _onAnimationCompleted(BuildContext context) async {
    if (!mounted) {
      return;
    }

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const BiometricPage(),
      ),
    );
  }
}
