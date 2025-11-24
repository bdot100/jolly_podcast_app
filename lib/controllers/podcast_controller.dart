import 'package:get/get.dart';
import '../models/podcast_model.dart';
import '../services/api_service.dart';

class PodcastController extends GetxController {
  final ApiService _apiService = ApiService();
  var isLoading = true.obs;
  var podcastList = <Podcast>[].obs;

  var editorPick = Rxn<Podcast>();

  @override
  void onInit() {
    fetchPodcasts();
    fetchEditorPick();
    super.onInit();
  }

  void fetchPodcasts() async {
    try {
      isLoading(true);
      var podcasts = await _apiService.fetchTrendingPodcasts();
      if (podcasts.isNotEmpty) {
        podcastList.assignAll(podcasts);
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to load podcasts: $e');
    } finally {
      isLoading(false);
    }
  }

  void fetchEditorPick() async {
    try {
      var podcast = await _apiService.fetchEditorPick();
      if (podcast != null) {
        editorPick.value = podcast;
      }
    } catch (e) {
      print('Error fetching editor pick: $e');
    }
  }
}
