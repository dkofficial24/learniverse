import 'package:learniverse/lesson/model/quiz.dart';

class Lesson {
  String title;
  String description;
  String content;
  bool isCompleted;
  int durationInMinutes;
  String videoUrl;
  String imageUrl;
  Quiz? quiz;

  Lesson({
    required this.title,
    required this.description,
    required this.content,
    required this.isCompleted,
    required this.durationInMinutes,
    required this.videoUrl,
    required this.imageUrl,
    this.quiz,
  });

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'content': content,
        'isCompleted': isCompleted,
        'durationInMinutes': durationInMinutes,
        'videoUrl': videoUrl,
        'imageUrl': imageUrl,
        'quiz': quiz
      };

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
        title: json['title'],
        description: json['description'],
        content: json['content'],
        isCompleted: json['isCompleted'],
        durationInMinutes: json['durationInMinutes'],
        videoUrl: json['videoUrl'],
        imageUrl: json['imageUrl'],
        quiz: json['quiz'],
      );
}
