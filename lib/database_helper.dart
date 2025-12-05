import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/user_model.dart';
import 'models/quiz_model.dart';
import 'models/question_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quizzy_v3.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 2,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
      onConfigure: _onConfigure,
    );
  }

  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  Future _createDB(Database db, int version) async {
    const userTable = '''
    CREATE TABLE users (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      name TEXT NOT NULL,
      email TEXT NOT NULL UNIQUE,
      password TEXT NOT NULL,
      profileImagePath TEXT
    )
    ''';

    const quizTable = '''
    CREATE TABLE quizzes (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      title TEXT NOT NULL,
      description TEXT NOT NULL,
      estimatedTime TEXT NOT NULL,
      ageRange TEXT NOT NULL,
      imagePath TEXT NOT NULL
    )
    ''';

    const questionTable = '''
    CREATE TABLE questions (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      quizId INTEGER NOT NULL,
      number INTEGER NOT NULL,
      questionText TEXT NOT NULL,
      a TEXT NOT NULL,
      b TEXT NOT NULL,
      c TEXT NOT NULL,
      d TEXT NOT NULL,
      FOREIGN KEY (quizId) REFERENCES quizzes (id) ON DELETE CASCADE
    )
    ''';

    await db.execute(userTable);
    await db.execute(quizTable);
    await db.execute(questionTable);

    await _seedData(db);
  }

  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute("DROP TABLE IF EXISTS questions");
      await db.execute("DROP TABLE IF EXISTS quizzes");
      await db.execute("DROP TABLE IF EXISTS users");
      await _createDB(db, newVersion);
    }
  }

  Future<int> registerUser(User user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  Future<User?> loginUser(String email, String password) async {
    final db = await instance.database;
    final maps = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );

    if (maps.isNotEmpty) {
      return User.fromMap(maps.first);
    } else {
      return null;
    }
  }

  Future<int> updateProfileImage(String email, String newPath) async {
    final db = await instance.database;

    return await db.update(
      'users',
      {'profileImagePath': newPath},
      where: 'email = ?',
      whereArgs: [email],
    );
  }


  Future<void> _seedData(Database db) async {
    // Insert quizzes
    await db.insert('quizzes', {
      'title': 'Personality Basics',
      'description': 'Discover your core personality type.',
      'estimatedTime': '5 min',
      'ageRange': '15-40',
      'imagePath': 'assets/img/quiz1.jpg'
    });

    await db.insert('quizzes', {
      'title': 'Career Style Quiz',
      'description': 'What type of worker are you?',
      'estimatedTime': '4 min',
      'ageRange': '16-40',
      'imagePath': 'assets/img/quiz2.jpg'
    });

    await db.insert('quizzes', {
      'title': 'Lifestyle Quiz',
      'description': 'Find out your lifestyle personality.',
      'estimatedTime': '6 min',
      'ageRange': '14-35',
      'imagePath': 'assets/img/quiz3.jpg'
    });

    // Insert questions for Quiz 1
    await db.insert('questions', {
      'quizId': 1,
      'number': 1,
      'questionText': 'How do you react in stressful situations?',
      'a': 'Stay calm and think logically',
      'b': 'Take control immediately',
      'c': 'Seek comfort from friends',
      'd': 'Try something creative or distracting'
    });

    await db.insert('questions', {
      'quizId': 1,
      'number': 2,
      'questionText': 'What do you value most in life?',
      'a': 'Knowledge',
      'b': 'Leadership',
      'c': 'Relationships',
      'd': 'Freedom'
    });

    // Insert questions for Quiz 2
    await db.insert('questions', {
      'quizId': 2,
      'number': 1,
      'questionText': 'How do you work best?',
      'a': 'With a clear plan',
      'b': 'Exploring freely',
      'c': 'Collaborating with others',
      'd': 'Leading your own project'
    });

    // Insert questions for Quiz 3
    await db.insert('questions', {
      'quizId': 3,
      'number': 1,
      'questionText': 'Your weekend looks like:',
      'a': 'Relax & recharge',
      'b': 'Adventure!',
      'c': 'Quality time with loved ones',
      'd': 'Learning something new'
    });
  }


  Future<List<Quiz>> getAllQuizzes() async {
    final db = await instance.database;
    final result = await db.query('quizzes');
    return result.map((map) => Quiz.fromMap(map)).toList();
  }

  Future<List<Question>> getQuestions(int quizId) async {
    final db = await instance.database;
    final maps = await db.query(
      'questions',
      where: 'quizId = ?',
      whereArgs: [quizId],
      orderBy: 'number ASC',
    );

    return List.generate(maps.length, (i) => Question.fromMap(maps[i]));
  }
}
