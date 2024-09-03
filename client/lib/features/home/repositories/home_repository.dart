import 'dart:convert';
import 'dart:io';

import 'package:fpdart/fpdart.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify/core/constants/server_constants.dart';
import 'package:spotify/core/failure/app_failure.dart';
import 'package:spotify/features/home/models/song_model.dart';

part 'home_repository.g.dart';

@riverpod
HomeRepository homeRepository(HomeRepositoryRef ref) {
  return HomeRepository();
}

class HomeRepository {
  Future<Either<AppFailureMsg, String>> uploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songName,
    required String artist,
    required String hexCode,
    required String token,
  }) async {
    try {
      final request = http.MultipartRequest(
          'POST', Uri.parse('${ServerConstants.serverUrl}/song/upload'));

      request
        ..files.addAll([
          await http.MultipartFile.fromPath('song', selectedAudio.path),
          await http.MultipartFile.fromPath(
              'thumbnail', selectedThumbnail.path),
        ])
        ..fields.addAll(
            {'artist': artist, 'song_name': songName, 'hex_code': hexCode})
        ..headers.addAll({'x-auth-token': token});

      final res = await request.send();

      if (res.statusCode != 201) {
        return Left(AppFailureMsg(await res.stream.bytesToString()));
      }

      return Right(await res.stream.bytesToString());
    } catch (e) {
      return Left(AppFailureMsg(e.toString()));
    }
  }

  Future<Either<AppFailureMsg, List<SongModel>>> getSongs({
    required String token,
  }) async {
    try {
      final res = await http.get(
        Uri.parse('${ServerConstants.serverUrl}/song/list'),
        headers: {
          'Content-type': 'application/json',
          'x-auth-token': token,
        },
      );

      var resBodyMap = jsonDecode(res.body);

      if (res.statusCode != 200) {
        resBodyMap = resBodyMap as Map<String, dynamic>;
        return Left(AppFailureMsg(resBodyMap['detail']));
      }

      List<SongModel> songs = [];
      resBodyMap = resBodyMap as List;
      for (var map in resBodyMap) {
        songs.add(SongModel.fromMap(map));
      }
      return Right(songs);
    } catch (e) {
      return Left(AppFailureMsg(e.toString()));
    }
  }
}
