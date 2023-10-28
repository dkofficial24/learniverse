import 'package:go_router/go_router.dart';
import 'package:learniverse/chapter/model/chapter.model.dart';
import 'package:learniverse/chapter/ui/add_chapter_screen.dart';
import 'package:learniverse/chapter/ui/chapter_screen.dart';
import 'package:learniverse/chapter/ui/list_chapter_screen.dart';
import 'package:learniverse/core/core.dart';
import 'package:learniverse/course/ui/add_course_screen.dart';
import 'package:learniverse/course/ui/list_course_screen.dart';

GoRouter getRouter() => _router;

final _router = GoRouter(
  routes: [
    GoRoute(
      path: RoutesName.homeScreen,
      builder: (context, state) => const ListCourseScreen(),
    ),
    GoRoute(
      path: RoutesName.addCourseScreen,
      builder: (context, state) => AddCourseScreen(),
    ),
    GoRoute(
      path: RoutesName.listChapterScreen,
      builder: (context, state) => ListChapterScreen(
        courseId: state.extra as String,
      ),
    ),
    GoRoute(
      path: RoutesName.addChapterScreen,
      builder: (context, state) => AddChapterScreen(
        courseId: state.extra as String,
      ),
    ),GoRoute(
      path: RoutesName.chapterScreen,
      builder: (context, state) => ChapterScreen(
        chapter: state.extra as Chapter,
      ),
    ),
  ],
);
