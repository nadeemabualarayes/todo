import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todotask/utils/colors.dart';
import 'dart:typed_data';

class BiometricPage extends StatefulWidget {
  const BiometricPage({Key key}) : super(key: key);

  @override
  State<BiometricPage> createState() => _BiometricPageState();
}

class _BiometricPageState extends State<BiometricPage> {
  TextEditingController domainController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String validateDomain(String value) {
    if (value.isEmpty) {
      return 'Domain must be not empty';
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 50.0,
                  ),
                  SvgPicture.asset(
                    "assets/logo.svg",
                    width: 100,
                    height: 180,
                    color: kRedColor,
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kWhiteColor,
                        border: Border.all(color: Colors.black12),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: TextFormField(
                          validator: validateDomain,
                          controller: domainController,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Domain',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 80.0,
                  ),
                  GestureDetector(
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
                  const SizedBox(
                    height: 120.0,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
