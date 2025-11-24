import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/player_controller.dart';
import '../../models/podcast_model.dart';
import '../../utils/constants.dart';

class PlayerView extends StatelessWidget {
  final Podcast podcast;
  final PlayerController _playerController = Get.put(PlayerController());

  PlayerView({required this.podcast}) {
    if (podcast.audioUrl != null) {
      _playerController.playPodcast(podcast.audioUrl!);
    }
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return '$minutes:$seconds';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 32),
          onPressed: () => Get.back(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 300,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(podcast.thumbnail ?? 'https://via.placeholder.com/300'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 32),
            Text(
              podcast.title ?? 'Unknown Title',
              style: GoogleFonts.outfit(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 8),
            Text(
              podcast.description ?? '',
              style: GoogleFonts.outfit(
                fontSize: 16,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            SizedBox(height: 32),
            Obx(() => Column(
              children: [
                Slider(
                  min: 0,
                  max: _playerController.duration.value.inSeconds.toDouble(),
                  value: _playerController.position.value.inSeconds.toDouble(),
                  activeColor: AppConstants.primaryColor,
                  inactiveColor: Colors.grey[300],
                  onChanged: (value) {
                    _playerController.seek(Duration(seconds: value.toInt()));
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(_formatDuration(_playerController.position.value)),
                      Text(_formatDuration(_playerController.duration.value)),
                    ],
                  ),
                ),
              ],
            )),
            SizedBox(height: 24),
            Obx(() => IconButton(
              iconSize: 80,
              color: AppConstants.primaryColor,
              icon: Icon(
                _playerController.isPlaying.value
                    ? Icons.pause_circle_filled
                    : Icons.play_circle_filled,
              ),
              onPressed: () {
                if (_playerController.isPlaying.value) {
                  _playerController.pause();
                } else {
                  _playerController.resume();
                }
              },
            )),
          ],
        ),
      ),
    );
  }
}
