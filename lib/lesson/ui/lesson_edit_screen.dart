import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as quill;
import 'package:flutter_quill_extensions/flutter_quill_extensions.dart';
import 'package:learniverse/core/editor/universal_ui.dart';
import 'package:learniverse/lesson/model/lesson.model.dart';
import 'package:learniverse/lesson/ui/lesson_preview.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class LessonEditScreen extends StatefulWidget {
  const LessonEditScreen({Key? key}) : super(key: key);

  @override
  _LessonEditScreenState createState() => _LessonEditScreenState();
}

class _LessonEditScreenState extends State<LessonEditScreen> {
  late quill.QuillController _controller;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller = quill.QuillController.basic();
  }

  Future<String?> _webImagePickImpl(
      OnImagePickCallback onImagePickCallback) async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) {
      return null;
    }

    // Take first, because we don't allow picking multiple files.
    final fileName = result.files.first.name;
    final file = File(fileName);

    return onImagePickCallback(file);
  }

  Future<String> _onImagePickCallback(File file) async {
    // Copies the picked file from temporary cache to applications directory
    final appDocDir = await getApplicationDocumentsDirectory();
    final copiedFile =
    await file.copy('${appDocDir.path}/${basename(file.path)}');
    return copiedFile.path.toString();
  }

  // bool _isDesktop() => !kIsWeb && !Platform.isAndroid && !Platform.isIOS;

  Future<String?> openFileSystemPickerForDesktop(BuildContext context) async {
    return await FilesystemPicker.open(
      context: context,
      rootDirectory: await getApplicationDocumentsDirectory(),
      fsType: FilesystemType.file,
      fileTileSelectMode: FileTileSelectMode.wholeTile,
    );
  }

  @override
  Widget build(BuildContext context) {

    // var toolbar = quill.QuillToolbar.basic(
    //   controller: _controller,
    //   embedButtons: FlutterQuillEmbeds.buttons(
    //     // provide a callback to enable picking images from device.
    //     // if omit, "image" button only allows adding images from url.
    //     // same goes for videos.
    //     onImagePickCallback: _onImagePickCallback,
    //     // onVideoPickCallback: _onVideoPickCallback,
    //     // uncomment to provide a custom "pick from" dialog.
    //     // mediaPickSettingSelector: _selectMediaPickSetting,
    //     // uncomment to provide a custom "pick from" dialog.
    //     // cameraPickSettingSelector: _selectCameraPickSetting,
    //   ),
    //   showAlignmentButtons: true,
    //   afterButtonPressed: _focusNode.requestFocus,
    // );


    var  toolbar = quill.QuillToolbar.basic(
        controller: _controller,
        embedButtons: FlutterQuillEmbeds.buttons(
          onImagePickCallback: _onImagePickCallback,
          webImagePickImpl: _webImagePickImpl,
        ),
        showAlignmentButtons: true,
        afterButtonPressed: _focusNode.requestFocus,
      );

    //
    // if (_isDesktop()) {
    //   toolbar = quill.QuillToolbar.basic(
    //     controller: _controller!,
    //     embedButtons: FlutterQuillEmbeds.buttons(
    //       onImagePickCallback: _onImagePickCallback,
    //       filePickImpl: openFileSystemPickerForDesktop,
    //     ),
    //     showAlignmentButtons: true,
    //     afterButtonPressed: _focusNode.requestFocus,
    //   );
    // }
    return Scaffold(
      appBar: AppBar(title: const Text('Lesson Form')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Title'),
              onChanged: (value) {},
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Description'),
              onChanged: (value) {},
            ),
            Expanded(
              child: Column(
                children: [
                  toolbar,
                  Expanded(
                    child: quill.QuillEditor(
                      controller: _controller,
                      scrollController: ScrollController(),
                      scrollable: true,
                      focusNode: _focusNode,
                      autoFocus: false,
                      readOnly: false,
                      placeholder: 'Add content',
                      expands: false,
                      padding: EdgeInsets.zero,
                      embedBuilders: defaultEmbedBuildersWeb,
                    )
                  )
                ],
              ),
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Duration (minutes)'),
              onChanged: (value) {
                // widget.lesson.durationInMinutes = int.parse(value);
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Video URL'),
              onChanged: (value) {
                // widget.lesson.videoUrl = value;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Image URL'),
              onChanged: (value) {
                // widget.lesson.imageUrl = value;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration:
                  const InputDecoration(labelText: 'Quiz duration (minutes)'),
              onChanged: (value) {
                // widget.lesson.quizDurationInMinutes = int.parse(value);
              },
            ),
            const SizedBox(height: 16),
            ElevatedButton(
                onPressed: () {
                  // //  widget.lesson.content = _controller.document.toJson();
                  //  // widget.onSubmit(widget.lesson);

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LessonPreview(
                              lesson: Lesson(
                                title: "",
                                content: jsonEncode(
                                    _controller.document.toDelta().toJson()),
                                description: "",
                                durationInMinutes: 0,
                                imageUrl: "",
                                isCompleted: true,
                                videoUrl: '',
                              ),
                            )),
                  );
                },
                child: Text("Submit"))
          ],
        ),
      ),
    );
  }
}
