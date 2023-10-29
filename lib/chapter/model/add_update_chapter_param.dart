import 'package:learniverse/chapter/model/chapter.model.dart';

class AddEditChapterParam {
  final String courseId;
  Chapter? chapter;

  AddEditChapterParam({
    required this.courseId,
    this.chapter,
  });
}
