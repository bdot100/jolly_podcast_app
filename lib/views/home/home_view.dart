import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'podcast_list_view.dart';
import '../favorites/favorites_view.dart';
import '../profile/profile_view.dart';
import '../widgets/mini_player.dart';
import '../../controllers/player_controller.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _currentIndex = 0;
  final PlayerController _playerController = Get.put(PlayerController());

  final List<Widget> _views = [
    PodcastListView(),
    FavoritesView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good morning',
              style: GoogleFonts.outfit(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Listen to your favorite podcast',
              style: GoogleFonts.outfit(
                color: Theme.of(context).textTheme.bodyMedium?.color,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          CircleAvatar(
            backgroundImage: NetworkImage('https://placehold.co/150.png'),
          ),
          SizedBox(width: 16),
          Icon(Icons.notifications, color: Theme.of(context).iconTheme.color),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _views[_currentIndex]),
          Obx(() {
            if (_playerController.currentPodcast.value != null) {
              return MiniPlayer();
            } else {
              return SizedBox.shrink();
            }
          }),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Theme.of(context).bottomNavigationBarTheme.backgroundColor,
        selectedItemColor: Theme.of(context).bottomNavigationBarTheme.selectedItemColor,
        unselectedItemColor: Theme.of(context).bottomNavigationBarTheme.unselectedItemColor,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.podcasts),
            label: 'Discover',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.grid_view_rounded),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.library_music),
            label: 'Your Library',
          ),
        ],
      ),
    );
  }
}
