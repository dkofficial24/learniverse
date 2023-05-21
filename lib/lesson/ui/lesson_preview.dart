import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill ;
import 'package:learniverse/lesson/model/lesson.model.dart';


class LessonPreview extends StatelessWidget {
  final Lesson lesson;

  const LessonPreview({required this.lesson});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Lesson Preview')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                lesson.title,
                style: Theme.of(context).textTheme.headline6,
              ),
              SizedBox(height: 8),
              Text(
                lesson.description,
                style: Theme.of(context).textTheme.subtitle1,
              ),
              SizedBox(height: 16),
              Container(
                child: quill.QuillEditor.basic(
                  controller: quill.QuillController(
                    document: quill.Document.fromJson(jsonDecode(lesson.content)),
                    selection: TextSelection.collapsed(offset: 0),
                  ),readOnly: true
                ),
              ),
              SizedBox(height: 16),
              Text(
                'Duration: ${lesson.durationInMinutes} minutes',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                'Video URL: ${lesson.videoUrl}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              Text(
                'Image URL: ${lesson.imageUrl}',
                style: Theme.of(context).textTheme.subtitle1,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                child: const Text('Edit'),
                onPressed: () {

                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
