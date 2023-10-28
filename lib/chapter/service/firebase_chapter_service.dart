import 'package:firebase_database/firebase_database.dart';
import 'package:learniverse/chapter/model/chapter.model.dart';

class ChapterFirebaseService {
  Future addChapter(Chapter chapter) async {
    final ref = FirebaseDatabase.instance.ref();
    final chapterRef = ref.child('chapter').child(chapter.courseId.toString()).push();
    chapter.id = chapterRef.key;
    await chapterRef.set(chapter.toJson());
    print('Done');
  }

  Stream<DatabaseEvent> getAllChapters(String courseId) {
    return FirebaseDatabase.instance.ref('chapter').child(courseId).onValue;
  }
}
