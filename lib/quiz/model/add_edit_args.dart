import 'package:learniverse/quiz/model/quiz_model.dart';

class AddEditArgs {
  String chapterId;
  QuizQuestion? question;

  AddEditArgs({
    required this.chapterId,
    this.question,
  });
}
