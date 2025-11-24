import 'package:flutter/material.dart';

class AppConstants {
  static const String baseUrl = 'https://api.jollypodcast.net';
  static const String loginEndpoint = '$baseUrl/api/auth/login';
  static const String podcastsEndpoint = '$baseUrl/api/podcasts/top-jolly';
  static const String handPickedPodcastsEndpoint = '$baseUrl/api/podcasts/handpicked';

  // Colors
  static const Color primaryColor = Color(0xFF6200EE); // Example primary color, adjust as needed
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color errorColor = Color(0xFFB00020);
}
