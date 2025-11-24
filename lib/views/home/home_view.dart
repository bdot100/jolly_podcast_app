import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../utils/constants.dart';
import 'podcast_list_view.dart';
import '../favorites/favorites_view.dart';
import '../profile/profile_view.dart';

class HomeView extends StatelessWidget {
  final RxInt _selectedIndex = 0.obs;

  final List<Widget> _views = [
    PodcastListView(),
    FavoritesView(),
    ProfileView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppConstants.backgroundColor,
      appBar: AppBar(
        title: Obx(() {
          switch (_selectedIndex.value) {
            case 0:
              return Text('Discover', style: GoogleFonts.outfit(fontWeight: FontWeight.bold));
            case 1:
              return Text('Favorites', style: GoogleFonts.outfit(fontWeight: FontWeight.bold));
            case 2:
              return Text('Profile', style: GoogleFonts.outfit(fontWeight: FontWeight.bold));
            default:
              return Text('Jolly Podcast', style: GoogleFonts.outfit(fontWeight: FontWeight.bold));
          }
        }),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
        automaticallyImplyLeading: false,
      ),
      body: Obx(() => _views[_selectedIndex.value]),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
        currentIndex: _selectedIndex.value,
        onTap: (index) {
          _selectedIndex.value = index;
        },
        selectedItemColor: AppConstants.primaryColor,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.mic),
            label: 'Podcasts',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      )),
    );
  }
}
