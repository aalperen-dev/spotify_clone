import 'package:hive/hive.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:spotify/features/home/models/song_model.dart';

part 'home_local_repository.g.dart';

@riverpod
HomeLocalRepository homeLocalRepository(HomeLocalRepositoryRef ref) {
  return HomeLocalRepository();
}

class HomeLocalRepository {
  final Box box = Hive.box();

  void uploadLocalSong(SongModel songModel) {
    box.put(songModel.id, songModel.toJson());
  }

  List<SongModel> loadSongs() {
    List<SongModel> songs = [];

    for (var key in box.keys) {
      songs.add(SongModel.fromJson(box.get(key)));
    }

    return songs;
  }
}
