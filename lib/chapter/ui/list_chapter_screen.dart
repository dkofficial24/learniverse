import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:learniverse/chapter/model/add_update_chapter_param.dart';
import 'package:learniverse/chapter/model/chapter.model.dart';
import 'package:learniverse/chapter/provider/chapter_provider.dart';
import 'package:learniverse/core/core.dart';
import 'package:learniverse/util/extensions/string_extension.dart';
import 'package:learniverse/util/widget/app_alert_dialog.dart';
import 'package:provider/provider.dart';

class ListChapterScreen extends StatefulWidget {
  const ListChapterScreen({Key? key, required this.courseId}) : super(key: key);
  final String courseId;

  @override
  State<ListChapterScreen> createState() => _ListChapterScreenState();
}

class _ListChapterScreenState extends State<ListChapterScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<ChapterProvider>(context, listen: false)
          .subscribeChapterEvents(widget.courseId);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.go(RoutesName.addEditChapterScreen.toPath,
                extra: AddEditChapterParam(
                  courseId: widget.courseId,
                ));
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16),
            child: Consumer<ChapterProvider>(
              builder: (context, provider, child) {
                return ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        context.go(
                          RoutesName.chapterScreen.toPath,
                          extra: provider.chapterList[index],
                        );
                      },
                      child: ListTile(
                        title: Text(
                          provider.chapterList[index].title,
                          textAlign: TextAlign.center,
                        ),
                        trailing: const Icon(Icons.keyboard_arrow_right),
                        leading: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            IconButton(
                              onPressed: () {
                                context.go(
                                  RoutesName.addEditChapterScreen.toPath,
                                  extra: AddEditChapterParam(
                                    courseId: widget.courseId,
                                    chapter: provider.chapterList[index],
                                  ),
                                );
                              },
                              icon: const Icon(
                                Icons.edit,
                              ),
                            ),
                            IconButton(
                              onPressed: () {
                                showDeleteDialog(
                                  provider.chapterList[index],
                                );
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Divider();
                  },
                  itemCount: provider.chapterList.length,
                );
              },
            )));
  }

  void showDeleteDialog(Chapter chapter) {
    showDialog(
        context: context,
        builder: (context) {
          return AppAlertDialog(
            title: 'Delete alert?',
            content: 'Do you want to delete it?',
            callback: () {
              deleteChapter(context, chapter);
            },
          );
        });
  }

  Future<void> deleteChapter(BuildContext context, Chapter chapter) async {
    await Provider.of<ChapterProvider>(context, listen: false).deleteChapter(
      chapter,
    );
  }
}
