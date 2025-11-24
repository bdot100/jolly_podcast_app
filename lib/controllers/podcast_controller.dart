import 'package:get/get.dart';
import '../models/podcast_model.dart';
import '../services/api_service.dart';

class PodcastController extends GetxController {
  final ApiService _apiService = ApiService();
  var isLoading = true.obs;
  var podcastList = <Podcast>[].obs;

  @override
  void onInit() {
    fetchPodcasts();
    super.onInit();
  }

  void fetchPodcasts() async {
    try {
      isLoading(true);
      var podcasts = await _apiService.fetchPodcasts();
      if (podcasts.isNotEmpty) {
        podcastList.assignAll(podcasts);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load podcasts: $e');
    } finally {
      isLoading(false);
    }
  }
}
