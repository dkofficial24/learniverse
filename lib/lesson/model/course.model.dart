import 'package:learniverse/lesson/model/lesson.model.dart';

class Course {
  String title;
  String description;
  String imageUrl;
  List<Lesson> lessons;
  bool isCompleted;

  Course({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.lessons,
    required this.isCompleted,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'imageUrl': imageUrl,
    'lessons': List<dynamic>.from(lessons.map((lesson) => lesson.toJson())),
    'isCompleted': isCompleted,
  };

  factory Course.fromJson(Map<String, dynamic> json) => Course(
    title: json['title'],
    description: json['description'],
    imageUrl: json['imageUrl'],
    lessons: List<Lesson>.from(json['lessons'].map((lesson) => Lesson.fromJson(lesson))),
    isCompleted: json['isCompleted'],
  );
}
