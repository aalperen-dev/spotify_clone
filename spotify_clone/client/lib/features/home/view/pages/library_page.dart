import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify/core/providers/current_song_notifier.dart';
import 'package:spotify/core/theme/app_palette.dart';
import 'package:spotify/core/widgets/app_loader.dart';
import 'package:spotify/features/home/view/pages/upload_song_page.dart';
import 'package:spotify/features/home/viewmodel/home_viewmodel.dart';

class LibraryPage extends ConsumerWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getAllFavoriteSongsProvider).when(
          data: (data) {
            return ListView.builder(
              itemCount: data.length + 1,
              itemBuilder: (context, index) {
                if (index == data.length) {
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const UploadSongPage(),
                      ));
                    },
                    leading: const CircleAvatar(
                      radius: 35,
                      backgroundColor: Pallete.backgroundColor,
                      child: Icon(Icons.add),
                    ),
                    title: const Text(
                      'Upload New Song',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  );
                }

                final song = data[index];
                return ListTile(
                  onTap: () {
                    ref
                        .read(currentSongNotifierProvider.notifier)
                        .updateSong(song);
                  },
                  leading: CircleAvatar(
                    radius: 35,
                    backgroundColor: Pallete.backgroundColor,
                    backgroundImage: NetworkImage(song.thumbnail_url),
                  ),
                  title: Text(
                    song.song_name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  subtitle: Text(
                    song.artist,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                );
              },
            );
          },
          error: (error, stackTrace) {
            return Center(
              child: Text(error.toString()),
            );
          },
          loading: () => const AppLoader(),
        );
  }
}
