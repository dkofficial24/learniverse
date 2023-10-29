import 'package:flutter/material.dart';
import 'package:learniverse/course/provider/course_provider.dart';
import 'package:learniverse/course/model/course.model.dart';
import 'package:provider/provider.dart';

class AddCourseScreen extends StatelessWidget {
  AddCourseScreen({Key? key}) : super(key: key);

  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final imageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                getTextFormField(
                    controller: nameController,
                    hint: 'Course Name',
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Input course name';
                      }
                      return null;
                    }),
                const SizedBox(
                  height: 16,
                ),
                getTextFormField(
                    controller: imageController,
                    hint: 'Image Url',
                    validator: (value) {
                      //todo do it later if required
                      return null;
                    }),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState?.validate() ?? false) {
                        addCourse(context);
                        clearFields();
                      }
                    },
                    child: const Text('Add Course'))
              ],
            ),
          ),
        ),
      ),
    );
  }

  void addCourse(BuildContext context) async {
    Provider.of<CourseProvider>(context, listen: false).addCourse(
      Course(
        name: nameController.text,
        description: descriptionController.text,
        imageUrl: imageController.text,
      ),
    );
  }

  void clearFields() {
    nameController.clear();
    descriptionController.clear();
    imageController.clear();
  }

  Widget getTextFormField({
    required TextEditingController controller,
    required String hint,
    FormFieldValidator<String>? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
      ),
      validator: validator,
    );
  }
}
