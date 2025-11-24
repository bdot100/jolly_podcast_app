import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/player_controller.dart';
import '../player/player_view.dart';

class MiniPlayer extends StatelessWidget {
  final PlayerController controller = Get.find<PlayerController>();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return GestureDetector(
      onTap: () {
        if (controller.currentPodcast.value != null) {
          Get.to(() => PlayerView());
        }
      },
      child: Container(
        height: 70,
        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: theme.cardColor,
          border: Border(
            top: BorderSide(color: theme.dividerColor.withOpacity(0.1)),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: Offset(0, -2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Thumbnail
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Obx(() => Image.network(
                controller.currentPodcast.value?.thumbnail ?? 'https://placehold.co/100.png',
                width: 50,
                height: 50,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  width: 50,
                  height: 50,
                  color: Colors.grey[800],
                  child: Icon(Icons.music_note, color: Colors.white),
                ),
              )),
            ),
            SizedBox(width: 12),
            
            // Title
            Expanded(
              child: Obx(() => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    controller.currentPodcast.value?.title ?? 'No Podcast Playing',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.outfit(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      color: theme.textTheme.bodyLarge?.color,
                    ),
                  ),
                  Text(
                    'Now Playing',
                    style: TextStyle(
                      fontSize: 12,
                      color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                    ),
                  ),
                ],
              )),
            ),
            
            // Controls
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.skip_previous, color: theme.iconTheme.color),
                  onPressed: () => controller.playPrevious(),
                ),
                Obx(() => IconButton(
                  icon: Icon(
                    controller.isPlaying.value ? Icons.pause_circle_filled : Icons.play_circle_fill,
                    color: theme.primaryColor,
                    size: 32,
                  ),
                  onPressed: () => controller.togglePlay(),
                )),
                IconButton(
                  icon: Icon(Icons.skip_next, color: theme.iconTheme.color),
                  onPressed: () => controller.playNext(),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
