import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:learniverse/chapter/model/chapter.model.dart';
import 'package:learniverse/chapter/provider/chapter_provider.dart';
import 'package:provider/provider.dart';

class AddChapterScreen extends StatefulWidget {
  const AddChapterScreen({
    Key? key,
    required this.courseId,
  }) : super(key: key);
  final String courseId;

  @override
  _AddChapterScreenState createState() => _AddChapterScreenState();
}

QuillController _controller = QuillController.basic();

class _AddChapterScreenState extends State<AddChapterScreen> {
  late TextEditingController _titleController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
  }

  // Function to create a TextFormField with an outlined border
  Widget _buildTextField(String labelText, TextEditingController controller,
      {int? maxLines, TextInputType? keyboardType}) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: labelText,
        border: const OutlineInputBorder(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Chapter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildTextField('Title', _titleController),
            const SizedBox(height: 16.0),
            Expanded(child: quillEditor()),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Create a Chapter instance with the entered values
                Chapter chapter = Chapter(
                    courseId: widget.courseId,
                    title: _titleController.text,
                    content:
                        jsonEncode(_controller.document.toDelta().toJson()));

                Provider.of<ChapterProvider>(context, listen: false)
                    .addChapter(chapter);
              },
              child: const Text('Add Chapter'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _titleController.dispose();
    super.dispose();
  }

  QuillProvider quillEditor() {
    return QuillProvider(
      configurations: QuillConfigurations(
        controller: _controller,
        sharedConfigurations: const QuillSharedConfigurations(
          locale: Locale('en'),
        ),
      ),
      child: Column(
        children: [
          const QuillToolbar(),
          Expanded(
            child: QuillEditor.basic(
              configurations: const QuillEditorConfigurations(
                readOnly: false,
              ),
            ),
          )
        ],
      ),
    );
  }
}
