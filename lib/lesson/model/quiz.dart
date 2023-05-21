class Quiz {
  final int id;
  final String title;
  final List<QuizQuestion> questions;

  Quiz({
    required this.id,
    required this.title,
    required this.questions,
  });
}

class QuizQuestion {
  final int id;
  final String question;
  final List<QuizOption> options;
  final int correctOptionIndex;

  QuizQuestion({
    required this.id,
    required this.question,
    required this.options,
    required this.correctOptionIndex,
  });
}

class QuizOption {
  final int id;
  final String text;

  QuizOption({
    required this.id,
    required this.text,
  });
}