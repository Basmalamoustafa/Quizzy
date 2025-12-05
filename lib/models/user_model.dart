class User {
  int? id;
  String name;
  String email;
  String password;
  String? profileImagePath;

  User({
    this.id,
    required this.name,
    required this.email,
    required this.password,
    this.profileImagePath,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'password': password,
      'profileImagePath': profileImagePath,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      name: map['name'],
      email: map['email'],
      password: map['password'],
      profileImagePath: map['profileImagePath'],
    );
  }

  // convenience copyWith so we can create modified copies
  User copyWith({
    int? id,
    String? name,
    String? email,
    String? password,
    String? profileImagePath,
  }) {
    return User(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      profileImagePath: profileImagePath ?? this.profileImagePath,
    );
  }
}
