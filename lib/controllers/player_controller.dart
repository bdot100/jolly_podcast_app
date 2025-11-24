import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/podcast_model.dart';

class PlayerController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  var isPlaying = false.obs;
  var duration = Duration.zero.obs;
  var position = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    _audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });
    _audioPlayer.onDurationChanged.listen((newDuration) {
      duration.value = newDuration;
    });
    _audioPlayer.onPositionChanged.listen((newPosition) {
      position.value = newPosition;
    });
  }

  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }

  void playPodcast(String url) async {
    try {
      await _audioPlayer.play(UrlSource(url));
    } catch (e) {
      Get.snackbar('Error', 'Could not play audio: $e');
    }
  }

  void pause() async {
    await _audioPlayer.pause();
  }

  void resume() async {
    await _audioPlayer.resume();
  }

  void seek(Duration position) {
    _audioPlayer.seek(position);
  }
}
