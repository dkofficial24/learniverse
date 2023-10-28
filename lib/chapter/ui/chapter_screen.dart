import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:learniverse/chapter/model/chapter.model.dart';
import 'package:learniverse/core/core.dart';
import 'package:learniverse/util/extensions/string_extension.dart';

class ChapterScreen extends StatefulWidget {
  const ChapterScreen({Key? key, required this.chapter}) : super(key: key);

  final Chapter chapter;

  @override
  State<ChapterScreen> createState() => _ChapterScreenState();
}

class _ChapterScreenState extends State<ChapterScreen> {
  late QuillController _controller;

  @override
  void initState() {
    _controller = QuillController(
        document: Document.fromJson(jsonDecode(widget.chapter.content)),
        selection: const TextSelection.collapsed(offset: 0));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                context.go(
                  RoutesName.quizScreen.toPath,
                  extra: widget.chapter.id,
                );
              },
              icon: const Icon(
                Icons.quiz,
              ))
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: 16, horizontal: MediaQuery.of(context).size.width * 0.2),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                widget.chapter.title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Expanded(child: buildEditor(widget.chapter.content)),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildEditor(String content) {
    return QuillProvider(
      configurations: QuillConfigurations(
        controller: _controller,
        sharedConfigurations: const QuillSharedConfigurations(
          locale: Locale('en'),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: QuillEditor.basic(
              configurations: const QuillEditorConfigurations(
                readOnly: true,
              ),
            ),
          )
        ],
      ),
    );
  }
}
