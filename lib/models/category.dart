import 'package:flutter/cupertino.dart';

class Category {
  int id;
  String name;
  String icon;
  String color;

  Category({
    this.id,
    this.name,
    this.icon,
    this.color,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'icon': icon,
      'color': color,
    };
  }

  Category.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    color = json['color'];
  }
}
