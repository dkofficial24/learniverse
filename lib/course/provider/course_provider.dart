import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:learniverse/core/core.dart';
import 'package:learniverse/course/service/course_firebase_service.dart';
import 'package:learniverse/course/model/course.model.dart';

class CourseProvider extends ChangeNotifier {
  CourseProvider(this.courseFirebaseService);

  CourseFirebaseService courseFirebaseService;

  StreamSubscription<DatabaseEvent>? _courseSubscription;

  bool isLoading = false;
  String? error;

  List<Course> courseList = [];

  Future addCourse(Course course) async {
    try {
      setLoadingState(true);
      error = null;
      notifyListeners();
      await courseFirebaseService.addCourse(course);
      AppUtils.showToast(msg: 'Course added successfully');
    } catch (e) {
      setErrorState(e.toString());
    }
    setLoadingState(false);
    notifyListeners();
  }

  Future<void> fetchAllCourses() async {
    try {
      setLoadingState(true);

      _courseSubscription =
          courseFirebaseService.listenAllCourses().listen((event) {
        DataSnapshot snapshot = event.snapshot;

        if (snapshot.exists) {
          updateCourseList(snapshot.value as Map);
        } else {
          throw 'Course does not exist';
        }
      });
    } catch (e) {
      // Handle errors
      setErrorState(e.toString());
    } finally {
      setLoadingState(false);
    }
  }

  void setLoadingState(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void setErrorState(String errorMessage) {
    error = errorMessage;
    notifyListeners();
  }

  void updateCourseList(Map data) {
    List<Course> courses = [];
    data.forEach((key, value) {
      courses.add(Course.fromJson(value));
    });
    courseList = courses;
    notifyListeners();
  }

  void closeStream() {
    _courseSubscription?.cancel();
  }
}
