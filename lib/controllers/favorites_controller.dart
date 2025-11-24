import 'package:get/get.dart';
import '../models/podcast_model.dart';
import '../services/api_service.dart';

class FavoritesController extends GetxController {
  final ApiService _apiService = ApiService();
  var isLoading = true.obs;
  var podcastList = <Podcast>[].obs;
  var filteredList = <Podcast>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchHandPicked();
  }

  void fetchHandPicked() async {
    try {
      isLoading(true);
      var podcasts = await _apiService.fetchHandPickedPodcasts(amount: 1);
      podcastList.assignAll(podcasts);
      filteredList.assignAll(podcasts);
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading(false);
    }
  }

  void search(String query) {
    if (query.isEmpty) {
      filteredList.assignAll(podcastList);
    } else {
      filteredList.assignAll(podcastList.where((podcast) {
        return (podcast.title?.toLowerCase().contains(query.toLowerCase()) ?? false) ||
               (podcast.description?.toLowerCase().contains(query.toLowerCase()) ?? false);
      }).toList());
    }
  }
}
