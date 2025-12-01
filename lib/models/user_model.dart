class User {
  final int? id;
  final String name;
  final String email;
  final String password;
  final String? profileImagePath; 

  User({this.id, required this.name, required this.email, required this.password, this.profileImagePath});

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
}