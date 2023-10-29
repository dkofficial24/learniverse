import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:learniverse/core/core.dart';
import 'package:learniverse/quiz/model/add_edit_args.dart';
import 'package:learniverse/quiz/provider/quiz_provider.dart';
import 'package:learniverse/quiz/ui/widget/question_widget.dart';
import 'package:learniverse/util/extensions/string_extension.dart';
import 'package:provider/provider.dart';

class QuizListScreen extends StatefulWidget {
  const QuizListScreen({Key? key, required this.chapterId}) : super(key: key);
  final String chapterId;

  @override
  State<QuizListScreen> createState() => _QuizListScreenState();
}

class _QuizListScreenState extends State<QuizListScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      loadQuizQuestions();
    });
    super.initState();
  }

  void loadQuizQuestions() {
    Provider.of<QuizProvider>(context, listen: false)
        .loadQuizQuestions(widget.chapterId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.go(
            RoutesName.addEditQuizScreen.toPath,
            extra: AddEditArgs(chapterId: widget.chapterId),
          );
        },
        child: const Icon(
          Icons.add,
        ),
      ),
      body: Consumer<QuizProvider>(
        builder: (BuildContext context, QuizProvider provider, Widget? child) {
          return Padding(
            padding: const EdgeInsets.all(16),
            child: ListView.builder(
                itemCount: provider.quizQuestions.length,
                itemBuilder: (context, index) {
                  return QuestionWidget(
                    chapterId: widget.chapterId,
                    quizQuestion: provider.quizQuestions[index],
                  );
                }),
          );
        },
      ),
    );
  }
}
