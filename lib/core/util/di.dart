import 'package:learniverse/chapter/service/firebase_chapter_service.dart';
import 'package:learniverse/course/service/course_firebase_service.dart';

class DI {
  static late CourseFirebaseService _courseFirebaseService;
  static late ChapterFirebaseService _chapterFirebaseService;

  static void init() {
    _courseFirebaseService = CourseFirebaseService();
    _chapterFirebaseService = ChapterFirebaseService();

    // );
  }

  static CourseFirebaseService getCourseFirebaseService() =>
      _courseFirebaseService;

  static ChapterFirebaseService getChapterFirebaseService() =>
      _chapterFirebaseService;
}
