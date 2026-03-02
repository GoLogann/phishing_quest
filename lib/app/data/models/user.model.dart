import 'package:phishing_quest/app/data/enumerators/user_role.enum.dart';

class UserModel {
  final String id;
  final String username;
  final String email;
  final UserRole role;
  final int score;
  final String? avatarUrl;
  final DateTime? createdAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    this.role = UserRole.player,
    this.score = 0,
    this.avatarUrl,
    this.createdAt,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] ?? '',
      username: json['username'] ?? '',
      email: json['email'] ?? '',
      role: UserRole.fromString(json['role'] ?? 'player'),
      score: json['score'] ?? 0,
      avatarUrl: json['avatar_url'],
      createdAt: json['created_at'] != null ? DateTime.tryParse(json['created_at']) : null,
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'username': username,
    'email': email,
    'role': role.name,
    'score': score,
    'avatar_url': avatarUrl,
    'created_at': createdAt?.toIso8601String(),
  };

  bool get isAdmin => role == UserRole.admin;
}
