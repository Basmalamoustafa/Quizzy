import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/user_model.dart';
import 'models/quiz_model.dart';
import 'models/question_model.dart';

// Handles all database operations (users, quizzes, questions)
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database; // Single database instance

  DatabaseHelper._init();

  // Gets db instance, creates it if needed
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quizzy_v3.db');
    return _database!;
  }

  // Initializes the db file
  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
      onConfigure: _onConfigure,
    );
  }

  // Enables foreign key constraints
  Future _onConfigure(Database db) async {
    await db.execute('PRAGMA foreign_keys = ON');
  }

  // Creates all tables and seeds initial data
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

  // Handles db version upgrades
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      await db.execute("DROP TABLE IF EXISTS questions");
      await db.execute("DROP TABLE IF EXISTS quizzes");
      await db.execute("DROP TABLE IF EXISTS users");
      await _createDB(db, newVersion);
    }
  }

  // Creates a new user account
  Future<int> registerUser(User user) async {
    final db = await instance.database;
    return await db.insert('users', user.toMap());
  }

  // Validates login credentials
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

  // Updates user's profile picture path
  Future<int> updateProfileImage(String email, String newPath) async {
    final db = await instance.database;

    return await db.update(
      'users',
      {'profileImagePath': newPath},
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  // Populates db with initial quiz and question data
  Future<void> _seedData(Database db) async {
    final quizzes = [
      {
        "id": 1,
        "title": "Personality Quiz 1",
        "description": "This is the first personality quiz.",
        "estimatedTime": "10 minutes",
        "ageRange": "12-18",
        "imagePath": "assets/img/quiz1.jpeg"
      },
      {
        "id": 2,
        "title": "Personality Quiz 2",
        "description": "This is the second personality quiz.",
        "estimatedTime": "15 minutes",
        "ageRange": "18-25",
        "imagePath": "assets/img/quiz2.jpeg"
      },
      {
        "id": 3,
        "title": "Personality Quiz 3",
        "description": "This is the third personality quiz.",
        "estimatedTime": "20 minutes",
        "ageRange": "25-35",
        "imagePath": "assets/img/quiz3.jpeg"
      }
    ];

    for (var quiz in quizzes) {
      await db.insert('quizzes', quiz,
          conflictAlgorithm: ConflictAlgorithm.replace);
    }

    final q1 = [
      {
        "number": 1,
        "questionText": "What is your favorite way to spend your free time?",
        "a": "Reading books",
        "b": "Playing video games",
        "c": "Hanging out with friends",
        "d": "Trying new hobbies"
      },
      {
        "number": 2,
        "questionText": "How do you handle conflicts with your friends?",
        "a": "Talk it out calmly",
        "b": "Avoid them until it blows over",
        "c": "Seek advice from others",
        "d": "Confront them directly"
      },
      {
        "number": 3,
        "questionText": "Which school subject do you enjoy the most?",
        "a": "Math",
        "b": "Art",
        "c": "Physical Education",
        "d": "Science"
      },
      {
        "number": 4,
        "questionText": "How do you prepare for exams?",
        "a": "Create a detailed study plan",
        "b": "Study the night before",
        "c": "Revise in a group",
        "d": "Review only the key points"
      },
      {
        "number": 5,
        "questionText": "If you could be any animal, which would you choose?",
        "a": "Dolphin",
        "b": "Lion",
        "c": "Owl",
        "d": "Dog"
      },
      {
        "number": 6,
        "questionText": "How do you feel about trying new activities?",
        "a": "Excited and eager",
        "b": "Nervous but willing",
        "c": "Reluctant but curious",
        "d": "Prefer sticking to what I know"
      },
      {
        "number": 7,
        "questionText": "When faced with a challenge, what do you do?",
        "a": "Seek help from others",
        "b": "Try to solve it on my own",
        "c": "Break it into smaller tasks",
        "d": "Avoid it and hope it resolves itself"
      },
      {
        "number": 8,
        "questionText": "What kind of movies do you enjoy the most?",
        "a": "Adventure",
        "b": "Comedy",
        "c": "Drama",
        "d": "Sci-fi"
      },
      {
        "number": 9,
        "questionText": "How would your best friends describe you?",
        "a": "Kind and caring",
        "b": "Fun and outgoing",
        "c": "Quiet and thoughtful",
        "d": "Brave and bold"
      },
      {
        "number": 10,
        "questionText": "If you could travel anywhere, where would you go?",
        "a": "A bustling city",
        "b": "A tropical beach",
        "c": "A quiet countryside",
        "d": "A historical site"
      }
    ];

    final q2 = [
      {
        "number": 1,
        "questionText": "What motivates you to work hard?",
        "a": "Achieving personal goals",
        "b": "Recognition from others",
        "c": "Financial rewards",
        "d": "Passion for what I do"
      },
      {
        "number": 2,
        "questionText": "How do you spend your weekends?",
        "a": "Catching up on rest",
        "b": "Exploring new places",
        "c": "Hanging out with friends",
        "d": "Working on personal projects"
      },
      {
        "number": 3,
        "questionText": "What type of career appeals to you most?",
        "a": "Creative and artistic",
        "b": "Practical and hands-on",
        "c": "Academic and research-based",
        "d": "Entrepreneurial"
      },
      {
        "number": 4,
        "questionText": "How do you handle criticism?",
        "a": "Take it as constructive feedback",
        "b": "Feel upset but reflect on it later",
        "c": "Brush it off",
        "d": "Challenge it if I disagree"
      },
      {
        "number": 5,
        "questionText": "What is your preferred way of learning?",
        "a": "Hands-on experience",
        "b": "Reading and studying",
        "c": "Attending workshops",
        "d": "Watching tutorials"
      },
      {
        "number": 6,
        "questionText": "How do you stay organized?",
        "a": "Use a planner or calendar",
        "b": "Keep mental notes",
        "c": "Make daily to-do lists",
        "d": "Organize only when necessary"
      },
      {
        "number": 7,
        "questionText": "Which type of music resonates with you?",
        "a": "Pop",
        "b": "Rock",
        "c": "Classical",
        "d": "Electronic"
      },
      {
        "number": 8,
        "questionText": "What is your favorite type of travel experience?",
        "a": "Backpacking adventures",
        "b": "Luxury resorts",
        "c": "Cultural explorations",
        "d": "Road trips"
      },
      {
        "number": 9,
        "questionText": "How do you prefer to spend time with friends?",
        "a": "Deep conversations",
        "b": "Casual hangouts",
        "c": "Attending events or parties",
        "d": "Collaborating on projects"
      },
      {
        "number": 10,
        "questionText": "What do you value most in a relationship?",
        "a": "Loyalty",
        "b": "Humor",
        "c": "Supportiveness",
        "d": "Shared interests"
      }
    ];

    final q3 = [
      {
        "number": 1,
        "questionText": "How do you define success in life?",
        "a": "Financial stability",
        "b": "Personal happiness",
        "c": "Strong relationships",
        "d": "Career achievements"
      },
      {
        "number": 2,
        "questionText": "What do you enjoy doing after work?",
        "a": "Exercising",
        "b": "Watching TV or movies",
        "c": "Spending time with family",
        "d": "Working on hobbies"
      },
      {
        "number": 3,
        "questionText": "How do you approach big decisions?",
        "a": "Research thoroughly before deciding",
        "b": "Trust my instincts",
        "c": "Discuss with close friends or family",
        "d": "Weigh the pros and cons"
      },
      {
        "number": 4,
        "questionText": "How do you like to spend your vacation time?",
        "a": "Relaxing and unwinding",
        "b": "Exploring new places",
        "c": "Visiting family or friends",
        "d": "Learning something new"
      },
      {
        "number": 5,
        "questionText": "How do you manage stress?",
        "a": "Exercise or meditate",
        "b": "Talk to someone I trust",
        "c": "Distract myself with entertainment",
        "d": "Plan and tackle the source of stress"
      },
      {
        "number": 6,
        "questionText": "What is your ideal way to celebrate your birthday?",
        "a": "A small, intimate gathering",
        "b": "A big party with everyone",
        "c": "A solo day of self-care",
        "d": "A fun adventure"
      },
      {
        "number": 7,
        "questionText": "Which of these hobbies would you enjoy the most?",
        "a": "Gardening",
        "b": "Cooking",
        "c": "Painting",
        "d": "Learning a new language"
      },
      {
        "number": 8,
        "questionText": "How do you usually set your goals?",
        "a": "Break them into smaller steps",
        "b": "Set ambitious, long-term goals",
        "c": "Go with the flow",
        "d": "Prioritize based on current needs"
      },
      {
        "number": 9,
        "questionText": "What type of books or media do you enjoy?",
        "a": "Self-help or motivational",
        "b": "Thrillers or mysteries",
        "c": "Historical or documentaries",
        "d": "Science fiction or fantasy"
      },
      {
        "number": 10,
        "questionText": "What do you think defines a fulfilling life?",
        "a": "Building strong relationships",
        "b": "Achieving personal dreams",
        "c": "Making a difference in the world",
        "d": "Living with balance and peace"
      }
    ];

    for (var q in q1) {
      await db.insert('questions', {...q, "quizId": 1});
    }

    for (var q in q2) {
      await db.insert('questions', {...q, "quizId": 2});
    }

    for (var q in q3) {
      await db.insert('questions', {...q, "quizId": 3});
    }
  }

  // Gets all available quizzes
  Future<List<Quiz>> getAllQuizzes() async {
    final db = await instance.database;
    final result = await db.query('quizzes');
    return result.map((map) => Quiz.fromMap(map)).toList();
  }

  // Gets all questions for a specific quiz
  Future<List<Question>> getQuestions(int quizId) async {
    final db = await instance.database;
    final maps = await db.query(
      'questions',
      where: 'quizId = ?',
      whereArgs: [quizId],
      orderBy: 'number ASC',
    );

    return maps.map((map) => Question.fromMap(map)).toList();
  }

  // Updates user password
  Future<int> changePassword(String email, String newPassword) async {
    final db = await instance.database;

    return await db.update(
      'users',
      {'password': newPassword},
      where: 'email = ?',
      whereArgs: [email],
    );
  }

  // Deletes user account
  Future<int> deleteUser(String email) async {
    final db = await instance.database;

    return await db.delete(
      'users',
      where: 'email = ?',
      whereArgs: [email],
    );
  }
}
