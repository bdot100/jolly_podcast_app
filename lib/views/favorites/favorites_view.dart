import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../controllers/favorites_controller.dart';
import '../../utils/constants.dart';
import '../widgets/podcast_list_item.dart';

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
            style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color),
            decoration: InputDecoration(
              hintText: 'Search favorites...',
              hintStyle: TextStyle(color: Theme.of(context).textTheme.bodyMedium?.color?.withOpacity(0.5)),
              prefixIcon: Icon(Icons.search, color: Theme.of(context).iconTheme.color),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Theme.of(context).cardColor,
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
              return Center(child: Text('No favorites found.', style: TextStyle(color: Theme.of(context).textTheme.bodyLarge?.color)));
            }
            return ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16),
              itemCount: _favoritesController.filteredList.length,
              itemBuilder: (context, index) {
                final podcast = _favoritesController.filteredList[index];
                return PodcastListItem(podcast: podcast);
              },
            );
          }),
        ),
      ],
    );
  }
}
