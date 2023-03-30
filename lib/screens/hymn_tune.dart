import 'common/widget.dart';
import 'package:flutter/material.dart';
import 'package:assets_audio_player/assets_audio_player.dart';

class HymnTune extends StatefulWidget {
  final String hymnMusicPath;
  const HymnTune({super.key, required this.hymnMusicPath});

  @override
  // ignore: library_private_types_in_public_api
  _HymnTuneState createState() => _HymnTuneState();
}

class _HymnTuneState extends State<HymnTune>
    with SingleTickerProviderStateMixin {
  late AnimationController iconController;
  bool isAnimated = false;
  bool showPlayButton = true;
  bool showPauseButton = false;
  double iconSize = 30.0;
  AssetsAudioPlayer hymnTunePlayer = AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    iconController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 100));
    hymnTunePlayer.open(Audio(widget.hymnMusicPath),
        autoStart: false, showNotification: true);
  }

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => animateIcon(),
      elevation: 10,
      backgroundColor: Styles.defaultBlueColor,
      tooltip: isAnimated != false ? 'Stop tune' : 'Listen to tune',
      foregroundColor: Colors.white,
      child: AnimatedIcon(
        icon: AnimatedIcons.play_pause,
        progress: iconController,
        size: iconSize,
        color: Colors.white,
      ),
    );
  }

  void animateIcon() {
    setState(() {
      isAnimated = !isAnimated;
      if (isAnimated) {
        iconController.forward();
        hymnTunePlayer.play();
      } else {
        iconController.reverse();
        hymnTunePlayer.pause();
      }
    });
  }

  @override
  void dispose() {
    hymnTunePlayer.dispose();
    super.dispose();
  }
}
