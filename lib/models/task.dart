class Task {
  int id;
  String title;
  String note;
  int isCompleted;
  String date;
  int categoryId;

  Task({
    this.id,
    this.title,
    this.note,
    this.isCompleted,
    this.date,
    this.categoryId,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'title': title,
      'note': note,
      'isCompleted': isCompleted,
      'date': date,
      'categoryId': categoryId,
    };
  }

  Task.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    note = json['note'];
    isCompleted = json['isCompleted'];
    date = json['date'];
    categoryId = json['categoryId'];
  }
}
