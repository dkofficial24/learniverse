import 'package:learniverse/chapter/service/firebase_chapter_service.dart';
import 'package:learniverse/course/service/course_firebase_service.dart';
import 'package:learniverse/quiz/service/firebase_quiz_service.dart';

class DI {
  static late CourseFirebaseService _courseFirebaseService;
  static late ChapterFirebaseService _chapterFirebaseService;
  static late FirebaseQuizService _quizFirebaseService;

  static void init() {
    _courseFirebaseService = CourseFirebaseService();
    _chapterFirebaseService = ChapterFirebaseService();
    _quizFirebaseService = FirebaseQuizService();

    // );
  }

  static CourseFirebaseService getCourseFirebaseService() =>
      _courseFirebaseService;

  static ChapterFirebaseService getChapterFirebaseService() =>
      _chapterFirebaseService;

  static FirebaseQuizService getQuizFirebaseService() => _quizFirebaseService;
}
