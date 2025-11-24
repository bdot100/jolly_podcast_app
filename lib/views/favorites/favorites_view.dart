import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/favorites_controller.dart';
import '../../utils/constants.dart';
import '../player/player_view.dart';

class FavoritesView extends StatelessWidget {
  final FavoritesController _favoritesController = Get.put(FavoritesController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            onChanged: (value) => _favoritesController.search(value),
            decoration: InputDecoration(
              hintText: 'Search favorites...',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.white,
              contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20),
            ),
          ),
        ),
        Expanded(
          child: Obx(() {
            if (_favoritesController.isLoading.value) {
              return Center(child: CircularProgressIndicator());
            }
            if (_favoritesController.filteredList.isEmpty) {
              return Center(child: Text('No favorites found.'));
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: _favoritesController.filteredList.length,
              itemBuilder: (context, index) {
                final podcast = _favoritesController.filteredList[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 2,
                  child: ListTile(
                    contentPadding: EdgeInsets.all(12),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        podcast.thumbnail ?? 'https://via.placeholder.com/150',
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey[300],
                          child: Icon(Icons.music_note),
                        ),
                      ),
                    ),
                    title: Text(
                      podcast.title ?? 'Unknown Title',
                      style: GoogleFonts.outfit(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      podcast.description ?? 'No description available.',
                      style: GoogleFonts.outfit(
                        color: Colors.grey[600],
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    trailing: Icon(Icons.play_circle_fill, color: AppConstants.primaryColor, size: 32),
                    onTap: () {
                      Get.to(() => PlayerView(podcast: podcast));
                    },
                  ),
                );
              },
            );
          }),
        ),
      ],
    );
  }
}
