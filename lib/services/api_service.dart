import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get_storage/get_storage.dart';
import '../utils/constants.dart';
import '../models/user_model.dart';
import '../models/podcast_model.dart';

class ApiService {
  final box = GetStorage();

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
      final body = jsonDecode(response.body);
      final data = body['data'];
      // Save token
      if (data != null && data['token'] != null) {
        final token = data['token'];
        box.write('token', token);
        print('DEBUG: Login successful. Token saved: $token');
      }
      return User.fromJson(body);
    } else {
      throw Exception('Failed to login: ${response.body}');
    }
  }

  Future<List<Podcast>> fetchPodcasts() async {
    final token = box.read('token');
    print('DEBUG: Token used for fetchPodcasts: $token');

    final response = await http.get(
      Uri.parse(AppConstants.podcastsEndpoint),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // Structure is data -> data -> data (list)
      final List<dynamic> podcastList = body['data']['data']['data'] ?? [];
      return podcastList.map((json) => Podcast.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load podcasts: ${response.body}');
    }
  }

  Future<List<Podcast>> fetchHandPickedPodcasts({int amount = 1}) async {
    final token = box.read('token');
    print('DEBUG: Token used for fetchHandPickedPodcasts: $token');

    final response = await http.get(
      Uri.parse('${AppConstants.handPickedPodcastsEndpoint}?amount=$amount'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // Structure is data -> data -> data (list)
      final List<dynamic> podcastList = body['data']['data']['data'] ?? [];
      return podcastList.map((json) => Podcast.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load hand-picked podcasts: ${response.body}');
    }
  }

  Future<List<Podcast>> fetchTrendingPodcasts({int page = 1, int perPage = 10}) async {
    final token = box.read('token');
    print('DEBUG: Token used for fetchTrendingPodcasts: $token');

    final response = await http.get(
      Uri.parse('${AppConstants.trendingPodcastsEndpoint}?page=$page&per_page=$perPage'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      final body = jsonDecode(response.body);
      // Structure is data -> data -> data (list)
      final List<dynamic> podcastList = body['data']['data']['data'] ?? [];
      return podcastList.map((json) => Podcast.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load trending podcasts: ${response.body}');
    }
  }

  Future<Podcast?> fetchEditorPick() async {
    final token = box.read('token');
    if (token == null) return null;

    try {
      final response = await http.get(
        Uri.parse(AppConstants.editorPickEndpoint),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        if (data['data'] != null && data['data']['data'] != null) {
          return Podcast.fromJson(data['data']['data']);
        }
      } else {
        print('Failed to load editor pick: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching editor pick: $e');
    }
    return null;
  }
}

