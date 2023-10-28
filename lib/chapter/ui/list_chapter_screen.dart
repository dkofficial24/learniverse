import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learniverse/chapter/provider/chapter_provider.dart';
import 'package:learniverse/core/core.dart';
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
    Provider.of<ChapterProvider>(context, listen: false)
        .subscribeChapterEvents(widget.courseId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.go(
              RoutesName.addChapterScreen,
              extra: widget.courseId,
            );
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
                          RoutesName.chapterScreen,
                          extra: provider.chapterList[index],
                        );
                      },
                      child: Text(
                        provider.chapterList[index].title,
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
}
