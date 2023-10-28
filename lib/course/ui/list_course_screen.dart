import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:go_router/go_router.dart';
import 'package:learniverse/core/core.dart';
import 'package:learniverse/course/provider/course_provider.dart';
import 'package:learniverse/lesson/model/course.model.dart';
import 'package:provider/provider.dart';

class ListCourseScreen extends StatefulWidget {
  const ListCourseScreen({Key? key}) : super(key: key);

  @override
  State<ListCourseScreen> createState() => _ListCourseScreenState();
}

class _ListCourseScreenState extends State<ListCourseScreen> {
  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      Provider.of<CourseProvider>(context, listen: false).fetchAllCourses();
    });
    super.initState();
  }

  @override
  void dispose() {
    Provider.of<CourseProvider>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CourseProvider>(builder: (context, provider, child) {
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            context.go(RoutesName.addCourseScreen);

            //Navigator.pushNamed(context, RoutesName.addCourseScreen);
          },
          child: const Icon(Icons.add),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Consumer<CourseProvider>(
            builder: (context, provider, child) {
              if (provider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (provider.error != null) {
                return Center(
                    child: Column(
                  children: [
                    Text(provider.error!),
                    const SizedBox(
                      height: 16,
                    ),
                    TextButton(
                      onPressed: () {
                        // provider.fetchCourses();
                      },
                      child: const Text('Retry'),
                    )
                  ],
                ));
              }

              return GridView.builder(
                  itemCount: provider.courseList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 4,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemBuilder: (context, index) {
                    Course course = provider.courseList[index];
                    return InkWell(
                      onTap: () {
                        context.go(
                          RoutesName.listChapterScreen,
                          extra: course.id,
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(8)),
                        child: Text(course.name),
                      ),
                    );
                  });
            },
          ),
        ),
      );
    });
  }
}
