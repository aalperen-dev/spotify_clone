// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

class FavoriteSongsModel {
  final String id;
  final String song_id;
  final String user_id;
  FavoriteSongsModel({
    required this.id,
    required this.song_id,
    required this.user_id,
  });

  FavoriteSongsModel copyWith({
    String? id,
    String? song_id,
    String? user_id,
  }) {
    return FavoriteSongsModel(
      id: id ?? this.id,
      song_id: song_id ?? this.song_id,
      user_id: user_id ?? this.user_id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'song_id': song_id,
      'user_id': user_id,
    };
  }

  factory FavoriteSongsModel.fromMap(Map<String, dynamic> map) {
    return FavoriteSongsModel(
      id: map['id'] ?? '',
      song_id: map['song_id'] ?? '',
      user_id: map['user_id'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory FavoriteSongsModel.fromJson(String source) =>
      FavoriteSongsModel.fromMap(json.decode(source));

  @override
  String toString() =>
      'FavoriteSongsModel(id: $id, song_id: $song_id, user_id: $user_id)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FavoriteSongsModel &&
        other.id == id &&
        other.song_id == song_id &&
        other.user_id == user_id;
  }

  @override
  int get hashCode => id.hashCode ^ song_id.hashCode ^ user_id.hashCode;
}
