import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/podcast_controller.dart';
import '../../utils/constants.dart';
import '../widgets/podcast_card.dart';
import '../widgets/podcast_list_item.dart';

class PodcastListView extends StatelessWidget {
  final PodcastController _podcastController = Get.put(PodcastController());

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text('🔥', style: TextStyle(fontSize: 24)),
              SizedBox(width: 8),
              Text(
                'Hot & trending episodes',
                style: GoogleFonts.outfit(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          SizedBox(
            height: 320, // Adjust height for card
            child: Obx(() {
              if (_podcastController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (_podcastController.podcastList.isEmpty) {
                return Center(child: Text('No podcasts found.', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)));
              }
              return ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: _podcastController.podcastList.length,
                itemBuilder: (context, index) {
                  final podcast = _podcastController.podcastList[index];
                  return PodcastCard(podcast: podcast);
                },
              );
            }),
          ),
          SizedBox(height: 24),
          Row(
            children: [
              Icon(Icons.star, color: Colors.purpleAccent, size: 24), // Using purple as per image star color approx
              SizedBox(width: 8),
              Text(
                "Editor's pick",
                style: GoogleFonts.outfit(
                  color: Theme.of(context).textTheme.bodyLarge?.color,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Obx(() {
            if (_podcastController.editorPick.value == null) {
              return Center(child: CircularProgressIndicator());
            }
            return PodcastListItem(podcast: _podcastController.editorPick.value!);
          }),
        ],
      ),
    );
  }
}
