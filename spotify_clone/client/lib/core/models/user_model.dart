import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:spotify/features/home/models/favorite_songs_model.dart';

class UserModel {
  final String id;
  final String email;
  final String name;
  final String token;
  final List<FavoriteSongsModel> favoriteSongs;
  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.token,
    required this.favoriteSongs,
  });

  UserModel copyWith({
    String? id,
    String? email,
    String? name,
    String? token,
    List<FavoriteSongsModel>? favoriteSongs,
  }) {
    return UserModel(
      id: id ?? this.id,
      email: email ?? this.email,
      name: name ?? this.name,
      token: token ?? this.token,
      favoriteSongs: favoriteSongs ?? this.favoriteSongs,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'token': token,
      'favoriteSongs': favoriteSongs.map((x) => x.toMap()).toList(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      email: map['email'] ?? '',
      name: map['name'] ?? '',
      token: map['token'] ?? '',
      favoriteSongs: List<FavoriteSongsModel>.from(
        (map['favorites'] ?? []).map(
          (x) => FavoriteSongsModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(id: $id, email: $email, name: $name, token: $token, favoriteSongs: $favoriteSongs)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.id == id &&
        other.email == email &&
        other.name == name &&
        other.token == token &&
        listEquals(other.favoriteSongs, favoriteSongs);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        email.hashCode ^
        name.hashCode ^
        token.hashCode ^
        favoriteSongs.hashCode;
  }
}
