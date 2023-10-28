import 'package:flutter/material.dart';
import 'package:learniverse/quiz/model/quiz_model.dart';

class QuestionWidget extends StatefulWidget {
  const QuestionWidget({
    required this.quizQuestion,
    super.key,
  });

  final QuizQuestion quizQuestion;

  @override
  State<QuestionWidget> createState() => _QuestionWidgetState();
}

class _QuestionWidgetState extends State<QuestionWidget> {


  int? selectedRadio;

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.quizQuestion.question),
          const SizedBox(height: 16),
          getRadioButton(value: 0, title: widget.quizQuestion.options[0],),
          const SizedBox(height: 8),
          getRadioButton(value: 1, title: widget.quizQuestion.options[1],),
          const SizedBox(height: 8),
          getRadioButton(value: 2, title: widget.quizQuestion.options[2],),
          const SizedBox(height: 8),
          getRadioButton(value: 3, title: widget.quizQuestion.options[3],),
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
}
