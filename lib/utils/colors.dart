import 'package:flutter/material.dart';

const kBackgroundColor = Color(0xFF343434);
const kRedColor = Color(0xFF8687E7);
const kWhiteColor = Color(0xFFFFFFFF);
//const kBackgroundColor = Color(0xFF343434);

double displayScreenWidth(context) {
  return MediaQuery.of(context).size.width;
}

double displayScreenHeight2(context) {
  return MediaQuery.of(context).size.height;
}

double displayScreenHeight(context) {
  return MediaQuery.of(context).size.height -
      MediaQuery.of(context).padding.top -
      AppBar().preferredSize.height;
}
