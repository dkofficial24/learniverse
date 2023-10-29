import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart';
import 'package:go_router/go_router.dart';
import 'package:learniverse/chapter/model/add_update_chapter_param.dart';
import 'package:learniverse/chapter/model/chapter.model.dart';
import 'package:learniverse/chapter/provider/chapter_provider.dart';
import 'package:provider/provider.dart';

class AddEditChapterScreen extends StatefulWidget {
  AddEditChapterScreen({
    Key? key,
    required this.addEditChapterParam,
  }) : super(key: key);
  AddEditChapterParam addEditChapterParam;

  @override
  _AddEditChapterScreenState createState() => _AddEditChapterScreenState();
}

class _AddEditChapterScreenState extends State<AddEditChapterScreen> {
  late TextEditingController _titleController;
  final QuillController _controller = QuillController.basic();
  bool isEditMode = false;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController();
    init();
  }

  void init() {
    if (widget.addEditChapterParam.chapter != null) {
      isEditMode = true;
      Chapter chapter = widget.addEditChapterParam.chapter!;
      _titleController.text = chapter.title;
      _controller.document = Document.fromJson(jsonDecode(chapter.content));
    }
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
        title: Text(isEditMode ? 'Edit Chapter' : 'Add Chapter'),
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
            isEditMode ? editButton(context) : addButton(context),
          ],
        ),
      ),
    );
  }

  ElevatedButton addButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () async {
        Chapter chapter = Chapter(
            courseId: widget.addEditChapterParam.courseId,
            title: _titleController.text,
            content: jsonEncode(_controller.document.toDelta().toJson()));

        await Provider.of<ChapterProvider>(context, listen: false)
            .addChapter(chapter);
        context.pop();
      },
      child: const Text('Add Chapter'),
    );
  }

  ElevatedButton editButton(BuildContext context) {
    return ElevatedButton(
        onPressed: () async {
          Chapter chapter = Chapter(
              id: widget.addEditChapterParam.chapter?.id,
              courseId: widget.addEditChapterParam.courseId,
              title: _titleController.text,
              content: jsonEncode(_controller.document.toDelta().toJson()));
          await Provider.of<ChapterProvider>(context, listen: false)
              .editChapter(chapter);
          context.pop();
        },
        child: const Text('Update Chapter'));
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
