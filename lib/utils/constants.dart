import 'package:flutter/material.dart';

class AppConstants {
  static const String baseUrl = 'https://api.jollypodcast.net';
  static const String loginEndpoint = '$baseUrl/api/auth/login';
  static const String podcastsEndpoint = '$baseUrl/api/podcasts/top-jolly';
  static const String handPickedPodcastsEndpoint = '$baseUrl/api/podcasts/handpicked';
  static const String trendingPodcastsEndpoint = '$baseUrl/api/episodes/trending';
  static const String editorPickEndpoint = '$baseUrl/api/episodes/editor-pick';

  // Colors
  static const Color primaryColor = Color(0xFFB5E63B); // Lime Green
  static const Color backgroundColor = Color(0xFF051814); // Dark Green/Black
  static const Color cardColor = Color(0xFF0F2922); // Slightly lighter dark green
  static const Color errorColor = Color(0xFFB00020);
  static const Color textColor = Colors.white;
  static const Color secondaryTextColor = Colors.grey;
}
