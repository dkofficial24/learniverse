import 'package:firebase_database/firebase_database.dart';
import 'package:learniverse/quiz/model/quiz_model.dart';

class FirebaseQuizService {
  Future<void> addQuiz({
    required String chapterId,
    required QuizQuestion quizQuestion,
  }) async {
    final ref = FirebaseDatabase.instance.ref('quiz/$chapterId');
    final quizRef = ref.push();
    quizQuestion.id = quizRef.key;
    await quizRef.set(quizQuestion.toJson());
  }

  Stream<DatabaseEvent> getQuiz(String chapterId) {
    final ref = FirebaseDatabase.instance.ref('quiz/$chapterId');
    return ref.onValue;
  }
}
