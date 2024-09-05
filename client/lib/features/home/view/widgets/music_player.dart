import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:spotify/core/providers/current_song_notifier.dart';
import 'package:spotify/core/theme/app_palette.dart';

class MusicPlayer extends ConsumerWidget {
  const MusicPlayer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentSong = ref.watch(currentSongNotifierProvider);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Scaffold(
        body: Column(
          children: [
            //
            Expanded(
              flex: 5,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 30),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: DecorationImage(
                      image: NetworkImage(currentSong!.thumbnail_url),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            //
            Expanded(
              flex: 4,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            currentSong.song_name,
                            style: const TextStyle(
                              color: Pallete.whiteColor,
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          Text(
                            currentSong.artist,
                            style: const TextStyle(
                              color: Pallete.subtitleText,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      //
                      const Expanded(
                        child: SizedBox(),
                      ),
                      //
                      IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite),
                      ),
                    ],
                  )
                ],
              ),
            ),
            //
            Column(
              children: [
                SliderTheme(
                  data: SliderTheme.of(context).copyWith(
                      activeTrackColor: Pallete.whiteColor,
                      inactiveTrackColor: Pallete.whiteColor.withOpacity(0.117),
                      thumbColor: Pallete.whiteColor,
                      trackHeight: 4,
                      overlayShape: SliderComponentShape.noOverlay),
                  child: Slider(
                    value: 0.5,
                    onChanged: (value) {},
                  ),
                ),
              ],
            ),
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'text',
                  style: TextStyle(
                    color: Pallete.subtitleText,
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                Text(
                  'text',
                  style: TextStyle(
                    color: Pallete.subtitleText,
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
