class Lesson {
  String title;
  String description;
  String content;
  bool isCompleted;
  int durationInMinutes;
  String videoUrl;
  String imageUrl;
  int quizDurationInMinutes;
  List<String> quizQuestions;
  List<String> quizAnswers;

  Lesson({
    required this.title,
    required this.description,
    required this.content,
    required this.isCompleted,
    required this.durationInMinutes,
    required this.videoUrl,
    required this.imageUrl,
    required this.quizDurationInMinutes,
    required this.quizQuestions,
    required this.quizAnswers,
  });

  Map<String, dynamic> toJson() => {
    'title': title,
    'description': description,
    'content': content,
    'isCompleted': isCompleted,
    'durationInMinutes': durationInMinutes,
    'videoUrl': videoUrl,
    'imageUrl': imageUrl,
    'quizDurationInMinutes': quizDurationInMinutes,
    'quizQuestions': quizQuestions,
    'quizAnswers': quizAnswers,
  };

  factory Lesson.fromJson(Map<String, dynamic> json) => Lesson(
    title: json['title'],
    description: json['description'],
    content: json['content'],
    isCompleted: json['isCompleted'],
    durationInMinutes: json['durationInMinutes'],
    videoUrl: json['videoUrl'],
    imageUrl: json['imageUrl'],
    quizDurationInMinutes: json['quizDurationInMinutes'],
    quizQuestions: List<String>.from(json['quizQuestions']),
    quizAnswers: List<String>.from(json['quizAnswers']),
  );
}
