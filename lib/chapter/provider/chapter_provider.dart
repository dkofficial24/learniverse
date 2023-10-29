import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/foundation.dart';
import 'package:learniverse/chapter/service/firebase_chapter_service.dart';
import 'package:learniverse/chapter/model/chapter.model.dart';
import 'package:learniverse/core/core.dart';

class ChapterProvider extends ChangeNotifier {
  ChapterProvider(this.chapterService);

  ChapterFirebaseService chapterService;
  bool isLoading = true;
  String? error;

  List<Chapter> chapterList = [];

  Future addChapter(Chapter chapter) async {
    try {
      _setLoadingState(true);
      await chapterService.addChapter(chapter);
      AppUtils.showToast(msg: 'Chapter added successfully');
    } catch (e) {
      _setErrorState(e.toString());
    }
    _setLoadingState(false);
  }

  Future editChapter(Chapter chapter) async {
    try {
      _setLoadingState(true);
      await chapterService.editChapter(chapter);
      AppUtils.showToast(msg: 'Chapter updated successfully');
    } catch (e) {
      _setErrorState(e.toString());
    }
    _setLoadingState(false);
  }

  Future deleteChapter(Chapter chapter) async {
    try {
      _setLoadingState(true);
      await chapterService.deleteChapter(chapter);
      AppUtils.showToast(msg: 'Chapter deleted successfully');
    } catch (e) {
      _setErrorState(e.toString());
    }
    _setLoadingState(false);
  }

  void subscribeChapterEvents(String courseId) {
    try {
      chapterList.clear(); //todo fix it
      _setLoadingState(true);
      chapterService.getAllChapters(courseId).listen((event) {
        DataSnapshot snapshot = event.snapshot;
        if (!snapshot.exists) return;
        updateChapterList(snapshot.value as Map);
      });
    } catch (e) {
      _setErrorState(e.toString());
    }
    _setLoadingState(false);
  }

  void updateChapterList(Map data) {
    List<Chapter> chapterList = [];
    data.forEach((key, value) {
      chapterList
          .add(Chapter.fromJson(Map<String, dynamic>.from(value as Map)));
    });
    this.chapterList = chapterList;
    notifyListeners();
  }

  void _setLoadingState(bool loading) {
    isLoading = loading;
    notifyListeners();
  }

  void _setErrorState(String errorMessage) {
    error = errorMessage;
    notifyListeners();
  }
}
