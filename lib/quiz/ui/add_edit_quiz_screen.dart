import 'package:flutter/material.dart';
import 'package:learniverse/quiz/model/add_edit_args.dart';
import 'package:learniverse/quiz/model/quiz_model.dart';
import 'package:learniverse/quiz/provider/quiz_provider.dart';
import 'package:learniverse/util/widget/app_alert_dialog.dart';
import 'package:provider/provider.dart';

class AddEditQuizScreen extends StatefulWidget {
  const AddEditQuizScreen({
    super.key,
    required this.addEditArgs,
  });

  final AddEditArgs addEditArgs;

  @override
  State<AddEditQuizScreen> createState() => _AddEditQuizScreenState();
}

class _AddEditQuizScreenState extends State<AddEditQuizScreen> {
  int? selectedRadio;

  final TextEditingController questionController = TextEditingController();
  final TextEditingController option1Controller = TextEditingController();
  final TextEditingController option2Controller = TextEditingController();
  final TextEditingController option3Controller = TextEditingController();
  final TextEditingController option4Controller = TextEditingController();

  final formKey = GlobalKey<FormState>();
  bool isEditMode = false;

  @override
  void initState() {
    if (widget.addEditArgs.question != null) {
      QuizQuestion question = widget.addEditArgs.question!;
      isEditMode = true;
      questionController.text = question.question;
      option1Controller.text = question.options[0];
      option2Controller.text = question.options[1];
      option3Controller.text = question.options[2];
      option4Controller.text = question.options[3];
      selectedRadio = question.correctOptionIndex;
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 16,
            horizontal: MediaQuery.of(context).size.width * 0.2,
          ),
          child: Column(
            children: [
              getTextFormField(
                  controller: questionController,
                  hint: 'Question',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Question is mandatory';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 16,
              ),
              getTextFormField(
                  controller: option1Controller,
                  hint: 'Option 1',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Option 1 is mandatory';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 16,
              ),
              getTextFormField(
                  controller: option2Controller,
                  hint: 'Option 2',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Option 2 is mandatory';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 16,
              ),
              getTextFormField(
                  controller: option3Controller,
                  hint: 'Option 3',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Option 3 is mandatory';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 16,
              ),
              getTextFormField(
                  controller: option4Controller,
                  hint: 'Option 4',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Option 4 is mandatory';
                    }
                    return null;
                  }),
              const SizedBox(
                height: 16,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Expanded(child: getRadioButton(title: 'Option 1', value: 0)),
                  Expanded(child: getRadioButton(title: 'Option 2', value: 1)),
                  Expanded(child: getRadioButton(title: 'Option 3', value: 2)),
                  Expanded(child: getRadioButton(title: 'Option 4', value: 3)),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              if (selectedRadio == null)
                const Text(
                  'Choose correct answer',
                  style: TextStyle(
                    color: Colors.red,
                  ),
                ),
              const SizedBox(
                height: 24,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        resetFields();
                      },
                      child: const Text('Reset')),
                  isEditMode
                      ? ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              QuizQuestion question = QuizQuestion(
                                  id: widget.addEditArgs.question?.id!,
                                  question: questionController.text,
                                  options: [
                                    option1Controller.text,
                                    option2Controller.text,
                                    option3Controller.text,
                                    option4Controller.text,
                                  ],
                                  correctOptionIndex: selectedRadio!);

                              Provider.of<QuizProvider>(context, listen: false)
                                  .editQuizQuestion(
                                widget.addEditArgs.chapterId,
                                question,
                              );
                            }
                          },
                          child: const Text('Update'))
                      : ElevatedButton(
                          onPressed: () {
                            if (formKey.currentState?.validate() ?? false) {
                              QuizQuestion question = QuizQuestion(
                                  question: questionController.text,
                                  options: [
                                    option1Controller.text,
                                    option2Controller.text,
                                    option3Controller.text,
                                    option4Controller.text,
                                  ],
                                  correctOptionIndex: selectedRadio!);

                              Provider.of<QuizProvider>(context, listen: false)
                                  .addQuizQuestion(
                                widget.addEditArgs.chapterId,
                                question,
                              );
                            }
                          },
                          child: const Text('Add')),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  void resetFields() {
    questionController.clear();
    option1Controller.clear();
    option2Controller.clear();
    option3Controller.clear();
    option4Controller.clear();
    selectedRadio = null;
    setState(() {});
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

  Widget getTextFormField({
    required TextEditingController controller,
    required String hint,
    required FormFieldValidator<String?> validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(),
      ),
      validator: validator,
    );
  }
}
