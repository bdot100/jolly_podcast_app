import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';
import '../../controllers/player_controller.dart';

class PlayerView extends StatelessWidget {
  final PlayerController controller = Get.find<PlayerController>();

  PlayerView({Key? key}) : super(key: key);

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    
    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: OutlinedButton(
            onPressed: () => Get.back(),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.zero,
              side: BorderSide(color: theme.iconTheme.color!.withOpacity(0.5)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.arrow_back_ios_new, size: 14, color: theme.iconTheme.color),
                SizedBox(width: 4),
                Text("Go back", style: TextStyle(fontSize: 12, color: theme.textTheme.bodyMedium?.color)),
              ],
            ),
          ),
        ),
        leadingWidth: 100,
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://placehold.co/150.png'),
          ),
          SizedBox(width: 16),
          Icon(Icons.notifications, color: theme.iconTheme.color),
          SizedBox(width: 16),
          Icon(Icons.search, color: theme.iconTheme.color),
          SizedBox(width: 16),
        ],
      ),
      body: Obx(() {
        final podcast = controller.currentPodcast.value;
        if (podcast == null) {
          return Center(child: Text("No podcast playing"));
        }

        return SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                podcast.title ?? 'Podcast Title',
                style: GoogleFonts.outfit(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(height: 20),
              Center(
                child: Container(
                  height: 350,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(podcast.thumbnail ?? 'https://placehold.co/300.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Stack(
                    children: [
                      Positioned(
                        bottom: 20,
                        left: 20,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "AMEYAW\nDEBRAH", // Placeholder or dynamic author
                              style: GoogleFonts.outfit(
                                fontSize: 24,
                                fontWeight: FontWeight.w900,
                                color: Colors.white,
                                height: 0.9,
                              ),
                            ),
                            Text(
                              "BLOGGER AND CONTENT CREATOR",
                              style: GoogleFonts.outfit(
                                fontSize: 10,
                                color: Colors.white70,
                                letterSpacing: 1.2,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Positioned(
                        top: 20,
                        right: 20,
                        child: Row(
                          children: [
                            // Logo placeholder
                            Icon(Icons.podcasts, color: Colors.white, size: 30),
                            SizedBox(width: 8),
                            Text(
                              "Change\nAfrica\nPodcast",
                              style: GoogleFonts.outfit(
                                color: Colors.white,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                                height: 1.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton.icon(
                    onPressed: () => controller.togglePlay(),
                    icon: Icon(controller.isPlaying.value ? Icons.pause_circle : Icons.play_circle, color: Colors.white),
                    label: Text(controller.isPlaying.value ? "Pause" : "Play", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF00C853), // Green play button
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.favorite_border, color: theme.iconTheme.color),
                    label: Text("Save", style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: theme.dividerColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                  OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.add_box_outlined, color: theme.iconTheme.color),
                    label: Text("Add to queue", style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                    style: OutlinedButton.styleFrom(
                      side: BorderSide(color: theme.dividerColor),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.share, size: 18, color: theme.iconTheme.color),
                      label: Text("Share episode", style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: theme.dividerColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.add_circle_outline, size: 18, color: theme.iconTheme.color),
                      label: Text("Add to playlist", style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(color: theme.dividerColor),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 32),
              Text(
                "EPISODE DETAILS",
                style: GoogleFonts.outfit(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.6),
                  letterSpacing: 1.0,
                ),
              ),
              SizedBox(height: 8),
              Text(
                "20 June, 23 - ${_formatDuration(controller.duration.value)}", // Placeholder date
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                ),
              ),
              SizedBox(height: 8),
              Text(
                podcast.title ?? 'Episode Title',
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: theme.textTheme.bodyLarge?.color,
                ),
              ),
              SizedBox(height: 12),
              Text(
                podcast.description ?? 'No description available.',
                style: GoogleFonts.outfit(
                  fontSize: 14,
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.8),
                  height: 1.5,
                ),
              ),
              SizedBox(height: 20),
              // Slider
              Slider(
                value: controller.position.value.inSeconds.toDouble().clamp(0.0, controller.duration.value.inSeconds.toDouble()),
                min: 0.0,
                max: controller.duration.value.inSeconds.toDouble(),
                activeColor: Color(0xFF00C853),
                inactiveColor: theme.dividerColor,
                onChanged: (value) {
                  controller.seek(Duration(seconds: value.toInt()));
                },
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(_formatDuration(controller.position.value), style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                    Text(_formatDuration(controller.duration.value), style: TextStyle(color: theme.textTheme.bodyMedium?.color)),
                  ],
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
