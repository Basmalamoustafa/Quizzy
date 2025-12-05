import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'models/user_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('quizzy.db');
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
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE IF NOT EXISTS users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        password TEXT NOT NULL,
        profileImagePath TEXT
      )
    ''');

    print("🔥 USERS TABLE CREATED");
  }

  // SAFE upgrade — does NOT delete data anymore
  Future _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print("⚠️ UPGRADE: old=$oldVersion → new=$newVersion");

    if (oldVersion < 2) {
      // Add only missing column if needed
      await db.execute("ALTER TABLE users ADD COLUMN profileImagePath TEXT");
    }
  }

  Future<int> registerUser(User user) async {
    final db = await instance.database;

    print("📥 REGISTERING USER: ${user.toMap()}");

    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<User?> loginUser(String email, String password) async {
    final db = await instance.database;

    final cleanEmail = email.trim().toLowerCase();
    final cleanPass = password.trim();

    print("🔍 LOGIN ATTEMPT → email='$cleanEmail', pass='$cleanPass'");

    final maps = await db.query(
      'users',
      where: 'LOWER(email) = ? AND password = ?',
      whereArgs: [cleanEmail, cleanPass],
    );

    print("🔎 QUERY RESULT → $maps");

    if (maps.isNotEmpty) {
      print("✅ LOGIN SUCCESS");
      return User.fromMap(maps.first);
    } else {
      print("❌ LOGIN FAILED — NO MATCH");
      return null;
    }
  }

  // ⭐ NEW: Update profile image path
  Future<int> updateProfileImage(String email, String imagePath) async {
    final db = await instance.database;

    return await db.update(
      'users',
      {'profileImagePath': imagePath},
      where: 'LOWER(email) = ?',
      whereArgs: [email.trim().toLowerCase()],
    );
  }
}
