import 'package:get/get.dart';
import 'package:audioplayers/audioplayers.dart';
import '../models/podcast_model.dart';

class PlayerController extends GetxController {
  final AudioPlayer _audioPlayer = AudioPlayer();
  
  // Observables
  final Rx<Podcast?> currentPodcast = Rx<Podcast?>(null);
  final RxBool isPlaying = false.obs;
  final Rx<Duration> duration = Duration.zero.obs;
  final Rx<Duration> position = Duration.zero.obs;

  @override
  void onInit() {
    super.onInit();
    _setupAudioPlayer();
  }

  void _setupAudioPlayer() {
    _audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying.value = state == PlayerState.playing;
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      duration.value = newDuration;
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      position.value = newPosition;
    });
    
    _audioPlayer.onPlayerComplete.listen((event) {
      isPlaying.value = false;
      position.value = Duration.zero;
    });
  }

  Future<void> playPodcast(Podcast podcast) async {
    // If playing the same podcast, just toggle play/pause? 
    // Or if it's a different one, load and play.
    if (currentPodcast.value?.id == podcast.id) {
      togglePlay();
    } else {
      currentPodcast.value = podcast;
      if (podcast.audioUrl != null) {
        await _audioPlayer.stop();
        await _audioPlayer.setSourceUrl(podcast.audioUrl!);
        await _audioPlayer.resume();
      }
    }
  }

  Future<void> togglePlay() async {
    if (isPlaying.value) {
      await _audioPlayer.pause();
    } else {
      await _audioPlayer.resume();
    }
  }

  Future<void> seek(Duration newPosition) async {
    await _audioPlayer.seek(newPosition);
  }

  Future<void> playNext() async {
    // Placeholder for next track logic
    Get.snackbar('Next', 'Playing next track (Not implemented)');
  }

  Future<void> playPrevious() async {
    // Placeholder for previous track logic
    Get.snackbar('Previous', 'Playing previous track (Not implemented)');
  }
  
  @override
  void onClose() {
    _audioPlayer.dispose();
    super.onClose();
  }
}
