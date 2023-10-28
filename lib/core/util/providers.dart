import 'package:learniverse/chapter/provider/chapter_provider.dart';
import 'package:learniverse/core/core.dart';
import 'package:learniverse/course/provider/course_provider.dart';
import 'package:learniverse/quiz/provider/quiz_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> initProviders = [
  ChangeNotifierProvider<CourseProvider>(
    create: (_) => CourseProvider(
      DI.getCourseFirebaseService(),
    ),
  ),
  ChangeNotifierProvider<ChapterProvider>(
    create: (_) => ChapterProvider(
      DI.getChapterFirebaseService(),
    ),
  ),
  ChangeNotifierProvider<QuizProvider>(
    create: (_) => QuizProvider(
      DI.getQuizFirebaseService(),
    ),
  ),
];
