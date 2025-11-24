import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FavoritesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Favorites',
        style: GoogleFonts.outfit(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
