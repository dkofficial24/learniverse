import 'package:flutter/cupertino.dart';
import 'package:learniverse/core/core.dart';
import 'package:learniverse/quiz/model/quiz_model.dart';
import 'package:learniverse/quiz/service/firebase_quiz_service.dart';

class QuizProvider extends ChangeNotifier {
  QuizProvider(this.firebaseQuizService);

  bool isLoading = false;
  List<QuizQuestion> quizQuestions = [];
  FirebaseQuizService firebaseQuizService;
  String? error;

  Future addQuizQuestion(String chapterId, QuizQuestion question) async {
    try {
      isLoading = true;
      error = null;
      notifyListeners();
      await firebaseQuizService.addQuiz(
          chapterId: chapterId, quizQuestion: question);
      AppUtils.showToast(msg: 'Question added successfully');
    } catch (e) {
      error = e.toString();
    }
    isLoading = true;
    notifyListeners();
  }

  Future loadQuizQuestions(String chapterId) async {
    try {
      quizQuestions.clear();
      isLoading = true;
      error = null;
      notifyListeners();
      firebaseQuizService.getQuiz(chapterId).listen((event) {
        final snapshot = event.snapshot;
        if (snapshot.exists) {
          final map = snapshot.value as Map<String, dynamic>;
          List<QuizQuestion> list = [];
          map.forEach((key, value) {
            list.add(QuizQuestion.fromJson(value));
          });
          quizQuestions = list;
          notifyListeners();
        }
      });
    } catch (e) {
      error = e.toString();
    }
    isLoading = true;
    notifyListeners();
  }
}
