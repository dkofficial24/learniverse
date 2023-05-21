import 'package:learniverse/lesson/model/course.model.dart';
import 'package:learniverse/lesson/model/lesson.model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final _databaseName = 'my_database.db';
  static final _databaseVersion = 1;

  static final lessonTable = 'Lesson';
  static final lessonColumnId = 'id';
  static final lessonColumnTitle = 'title';
  static final lessonColumnDescription = 'description';
  static final lessonColumnContent = 'content';
  static final lessonColumnIsCompleted = 'isCompleted';
  static final lessonColumnDurationInMinutes = 'durationInMinutes';
  static final lessonColumnVideoUrl = 'videoUrl';
  static final lessonColumnImageUrl = 'imageUrl';
  static final lessonColumnQuizDurationInMinutes = 'quizDurationInMinutes';
  static final lessonColumnCourseId = 'courseId';

  static final courseTable = 'Course';
  static final courseColumnId = 'id';
  static final courseColumnTitle = 'title';
  static final courseColumnDescription = 'description';

  static Database? _database;
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    }

    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, _databaseName);

    return await openDatabase(
      path,
      version: _databaseVersion,
      onCreate: _onCreate,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $lessonTable (
        $lessonColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $lessonColumnTitle TEXT NOT NULL,
        $lessonColumnDescription TEXT,
        $lessonColumnContent TEXT,
        $lessonColumnIsCompleted INTEGER DEFAULT 0,
        $lessonColumnDurationInMinutes INTEGER,
        $lessonColumnVideoUrl TEXT,
        $lessonColumnImageUrl TEXT,
        $lessonColumnQuizDurationInMinutes INTEGER,
        $lessonColumnCourseId INTEGER NOT NULL,
        FOREIGN KEY ($lessonColumnCourseId) REFERENCES $courseTable($courseColumnId)
      )
    ''');

    await db.execute('''
      CREATE TABLE $courseTable (
        $courseColumnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $courseColumnTitle TEXT NOT NULL,
        $courseColumnDescription TEXT
      )
    ''');
  }

  Future<int> insertLesson(Lesson lesson) async {
    final db = await database;

    return await db.insert(
      lessonTable,
      lesson.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> insertCourse(Course course) async {
    final db = await database;

    return await db.insert(
      courseTable,
      course.toJson(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Course>> getAllCourses() async {
    final db = await database;
    final courses = await db.query(courseTable);

    return courses.map((json) => Course.fromJson(json)).toList();
  }

  Future<List<Lesson>> getLessonsByCourse(int courseId) async {
    final db = await database;
    final lessons = await db.query(
      lessonTable,
      where: '$lessonColumnCourseId = ?',
      whereArgs: [courseId],
    );

    return lessons.map((json) => Lesson.fromJson(json)).toList();
  }
}
