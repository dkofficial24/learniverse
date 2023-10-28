import 'package:learniverse/lesson/model/quiz.dart';

class Chapter {
  String? id;
  String? courseId;
  String title;
  String content;

  Chapter({
    this.id,
    this.courseId,
    required this.title,
    required this.content,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'courseId': courseId,
        'title': title,
        'content': content,
      };

  factory Chapter.fromJson(Map<String, dynamic> json) => Chapter(
        id: json['id'],
        courseId: json['courseId'],
        title: json['title'],
        content: json['content'],
      );
}
