import 'package:firebase_database/firebase_database.dart';
import 'package:learniverse/core/core.dart';
import 'package:learniverse/course/model/course.model.dart';

class CourseFirebaseService {
  Future<void> addCourse(Course course) async {
    final databaseRef = FirebaseDatabase.instance.ref();
    final courseRef = databaseRef.child('courses').push();
    course.id = courseRef.key;
    await courseRef.set(course.toJson());
    Log.i('Course added successfully!');
  }

  Future<void> updateCourse(Course course) async {
    final databaseRef = FirebaseDatabase.instance.ref();
    await databaseRef
        .child('courses')
        .child(course.id!)
        .update(course.toJson());
    Log.i('Course updated successfully!');
  }


  Stream<DatabaseEvent> listenAllCourses()  {
    final databaseRef = FirebaseDatabase.instance.ref();
     return databaseRef.child('courses').onValue;
  }
}
