import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import '../models/user_model.dart';
import '../models/podcast_model.dart';

class ApiService {
  Future<User> login(String phone, String password) async {
    final response = await http.post(
      Uri.parse(AppConstants.loginEndpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer jollypodcast',
      },
      body: jsonEncode({
        'phone_number': phone,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Save token
      if (data['token'] != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', data['token']);
      }
      return User.fromJson(data);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<List<Podcast>> fetchPodcasts() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse(AppConstants.podcastsEndpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      // Adjust this based on actual response structure (e.g., data['data'] or just data)
      final List<dynamic> podcastList = data['data'] ?? data; 
      return podcastList.map((json) => Podcast.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load podcasts: ${response.body}');
    }
  }

  Future<List<Podcast>> fetchHandPickedPodcasts({int amount = 1}) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    final response = await http.get(
      Uri.parse('${AppConstants.handPickedPodcastsEndpoint}?amount=$amount'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final List<dynamic> podcastList = data['data'] ?? data;
      return podcastList.map((json) => Podcast.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load hand-picked podcasts: ${response.body}');
    }
  }
}

