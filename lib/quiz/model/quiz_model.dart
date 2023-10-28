class Quiz {
  late String? id;
  final String? chapterId;
  final String title;
  final List<QuizQuestion> questions;

  Quiz({
    this.id,
    this.chapterId,
    required this.title,
    required this.questions,
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    final List<dynamic> questionsJson = json['questions'] ?? [];

    return Quiz(
      id: json['id'],
      title: json['title'],
      chapterId: json['chapterId'],
      questions: questionsJson
          .map((questionJson) => QuizQuestion.fromJson(questionJson))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'chapterId': chapterId,
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }
}

class QuizQuestion {
  late String? id;
  final String question;
  final List<String> options;
  final int correctOptionIndex;

  QuizQuestion({
    this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });

  // Convert the QuizQuestion instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question,
      'options': options,
      'correctOptionIndex': correctOptionIndex,
    };
  }

  // Create a QuizQuestion instance from a Map
  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      id: json['id'],
      question: json['question'],
      options: List<String>.from(json['options']),
      correctOptionIndex: json['correctOptionIndex'],
    );
  }
}
