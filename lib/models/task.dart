import 'package:flutter/foundation.dart';

class Task {
  int id;
  String title;
  String note;
  int isCompleted;
  String date;
  //Category category;

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    //   this.category,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      //   'category': category,
    };
  }

  Task.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    //  category = json['category'];
  }
}
