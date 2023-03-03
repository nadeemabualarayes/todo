import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todotask/utils/colors.dart';

class BiometricPage extends StatefulWidget {
  const BiometricPage({Key key}) : super(key: key);

  @override
  State<BiometricPage> createState() => _BiometricPageState();
}

class _BiometricPageState extends State<BiometricPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              const SizedBox(
                height: 50.0,
              ),
              Expanded(
                child: Center(
                  child: SvgPicture.asset(
                    "assets/logo.svg",
                    width: 100,
                    height: 180,
                    color: kRedColor,
                  ),
                ),
              ),
              const SizedBox(
                height: 80.0,
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: GestureDetector(
                  onTap: () async {
                    Fluttertoast.showToast(
                        msg: "you cant",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: Colors.grey[300],
                        textColor: Colors.red,
                        fontSize: 16.0);
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      padding: const EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: kRedColor,
                      ),
                      child: const Center(
                          child: Text(
                        'Unlock App',
                        style: TextStyle(
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0),
                      )),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
