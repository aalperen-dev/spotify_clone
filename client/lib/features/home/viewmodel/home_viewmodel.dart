import 'dart:io';
import 'dart:ui';
import 'package:fpdart/fpdart.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify/core/providers/current_user_notifier.dart';
import 'package:spotify/core/utilities/utilities.dart';
import 'package:spotify/features/home/models/favorite_songs_model.dart';
import 'package:spotify/features/home/models/song_model.dart';
import 'package:spotify/features/home/repositories/home_local_repository.dart';
import 'package:spotify/features/home/repositories/home_repository.dart';

part 'home_viewmodel.g.dart';

@riverpod
Future<List<SongModel>> getAllSongs(GetAllSongsRef ref) async {
  final token = ref.watch(currentUserNotifierProvider.select(
    (value) => value!.token,
  ));
  final res = await ref.watch(homeRepositoryProvider).getAllSongs(token: token);

  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
Future<List<SongModel>> getAllFavoriteSongs(GetAllFavoriteSongsRef ref) async {
  final token = ref.watch(currentUserNotifierProvider.select(
    (value) => value!.token,
  ));
  final res =
      await ref.watch(homeRepositoryProvider).getAllFavoriteSongs(token: token);

  return switch (res) {
    Left(value: final l) => throw l.message,
    Right(value: final r) => r,
  };
}

@riverpod
class HomeViewModel extends _$HomeViewModel {
  late HomeRepository _homeRepository;
  late HomeLocalRepository _homeLocalRepository;

  @override
  AsyncValue? build() {
    _homeRepository = ref.watch(homeRepositoryProvider);
    _homeLocalRepository = ref.watch(homeLocalRepositoryProvider);
    return null;
  }

  Future<void> uploadSong({
    required File selectedAudio,
    required File selectedThumbnail,
    required String songName,
    required String artist,
    required Color selectedColor,
  }) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.uploadSong(
      selectedAudio: selectedAudio,
      selectedThumbnail: selectedThumbnail,
      songName: songName,
      artist: artist,
      hexCode: AppUtilities.rgbToHex(color: selectedColor),
      token: ref.read(currentUserNotifierProvider)!.token,
    );

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => state = AsyncValue.data(r),
    };
  }

  List<SongModel> getRecentlyPlayedSongs() {
    return _homeLocalRepository.loadSongs();
  }

  Future<void> favoriteSong({
    required String songId,
  }) async {
    state = const AsyncValue.loading();
    final res = await _homeRepository.favoriteSong(
      songId: songId,
      token: ref.read(currentUserNotifierProvider)!.token,
    );

    final val = switch (res) {
      Left(value: final l) => state =
          AsyncValue.error(l.message, StackTrace.current),
      Right(value: final r) => _favoriteSongSuccess(r, songId),
    };
  }

  AsyncValue _favoriteSongSuccess(
    bool isFavorited,
    String songId,
  ) {
    final userNotifer = ref.read(currentUserNotifierProvider.notifier);
    if (isFavorited) {
      userNotifer.addUser(
        ref.read(currentUserNotifierProvider)!.copyWith(
          favoriteSongs: [
            ...ref.read(currentUserNotifierProvider)!.favoriteSongs,
            FavoriteSongsModel(id: 'id', song_id: songId, user_id: 'user_id'),
          ],
        ),
      );
    } else {
      userNotifer.addUser(
        ref.read(currentUserNotifierProvider)!.copyWith(
            favoriteSongs: ref
                .read(currentUserNotifierProvider)!
                .favoriteSongs
                .where(
                  (element) => element.song_id != songId,
                )
                .toList()),
      );
    }
    ref.invalidate(getAllFavoriteSongsProvider);
    return state = AsyncValue.data(isFavorited);
  }
}
