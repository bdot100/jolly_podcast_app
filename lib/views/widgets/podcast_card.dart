import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../models/podcast_model.dart';
import '../../controllers/player_controller.dart';
import '../player/player_view.dart';

class PodcastCard extends StatelessWidget {
  final Podcast podcast;
  final PlayerController _playerController = Get.find<PlayerController>();

  PodcastCard({required this.podcast});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _playerController.playPodcast(podcast);
        Get.to(() => PlayerView());
      },
      child: Container(
        width: 250,
        margin: EdgeInsets.only(right: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Theme.of(context).cardColor,
          image: DecorationImage(
            image: NetworkImage(podcast.thumbnail ?? 'https://placehold.co/300.png'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.6),
              BlendMode.darken,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Text(
                podcast.title ?? 'No Title',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8),
              Text(
                podcast.description ?? 'No Description',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  color: Colors.white70,
                  fontSize: 12,
                ),
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Theme.of(context).primaryColor,
                    child: Icon(Icons.play_arrow, color: Colors.white),
                  ),
                  SizedBox(width: 8),
                  Text(
                    'Play now',
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
