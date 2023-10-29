import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:learniverse/core/core.dart';
import 'package:learniverse/quiz/model/add_edit_args.dart';
import 'package:learniverse/quiz/model/quiz_model.dart';
import 'package:learniverse/quiz/provider/quiz_provider.dart';
import 'package:learniverse/util/extensions/string_extension.dart';
import 'package:learniverse/util/widget/app_alert_dialog.dart';
import 'package:provider/provider.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    required this.quizQuestion,
    required this.chapterId,
    super.key,
  });

  final QuizQuestion quizQuestion;
  final String chapterId;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {
  int? selectedRadio;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(widget.quizQuestion.question),
              IconButton(
                  onPressed: () {
                    context.go(
                      RoutesName.addEditQuizScreen.toPath,
                      extra: AddEditArgs(
                        chapterId: widget.chapterId,
                        question: widget.quizQuestion,
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.edit,
                  )),
              IconButton(
                  onPressed: () {
                    showDeleteDialog(
                      chapterId: widget.chapterId,
                      questionId: widget.quizQuestion.id!,
                    );
                  },
                  icon: const Icon(
                    Icons.delete,
                    color: Colors.red,
                  )),
            ],
          ),
          const SizedBox(height: 16),
          getRadioButton(
            value: 0,
            title: widget.quizQuestion.options[0],
          ),
          const SizedBox(height: 8),
          getRadioButton(
            value: 1,
            title: widget.quizQuestion.options[1],
          ),
          const SizedBox(height: 8),
          getRadioButton(
            value: 2,
            title: widget.quizQuestion.options[2],
          ),
          const SizedBox(height: 8),
          getRadioButton(
            value: 3,
            title: widget.quizQuestion.options[3],
          ),
        ],
      ),
    );
  }

  RadioListTile<int> getRadioButton({
    required int value,
    required String title,
  }) {
    return RadioListTile(
        value: value,
        title: Text(title),
        groupValue: selectedRadio,
        onChanged: (int? value) {
          selectedRadio = value;
          setState(() {});
        });
  }

  void showDeleteDialog({
    required String chapterId,
    required String questionId,
  }) {
    showDialog(
        context: context,
        builder: (context) {
          return AppAlertDialog(
            title: 'Delete alert?',
            content: 'Do you want to delete it?',
            callback: () {
              Provider.of<QuizProvider>(context, listen: false)
                  .deleteQuizQuestion(
                chapterId: chapterId,
                questionId: questionId,
              );
            },
          );
        });
  }
}
