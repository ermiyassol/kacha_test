class User {
  int? id; // Changed from Isar.autoIncrement to nullable int

  final String email;
  final String name;
  final String? phone;
  final String? token;

  User({
    this.id,
    required this.email,
    required this.name,
    this.phone,
    this.token,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'] as int?,
      email: json['email'] as String,
      name: json['name'] as String,
      phone: json['phone'] as String?,
      token: json['token'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'phone': phone,
      'token': token,
    };
  }
}
