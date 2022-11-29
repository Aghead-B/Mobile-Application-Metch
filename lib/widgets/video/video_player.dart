import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'video_overlay.dart';

class VideoPlayerWidget extends StatefulWidget {
  const VideoPlayerWidget({super.key});

  @override
  _VideoPlayerState createState() => _VideoPlayerState();
}

class _VideoPlayerState extends State<VideoPlayerWidget> {
  final asset = "assets/videos/test.mp4";
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(asset)
      ..addListener(() => setState(() {}))
      ..setLooping(false)
      ..initialize().then((_) => controller.play());
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        controller.value.isInitialized
            ? Container(alignment: Alignment.topCenter, child: buildVideo())
            : Container(
          height: 200,
          child: const Center(
              child: CircularProgressIndicator(color: Colors.white,)),
        ),
      ],
    );
  }

  Widget buildVideo() =>
      Stack(
        children: <Widget>[
          buildVideoPlayer(),
          Positioned.fill(child: VideoOverlay(controller: controller)),
        ],
      );

  Widget buildVideoPlayer() =>
      AspectRatio(
        aspectRatio: controller.value.aspectRatio,
        child: VideoPlayer(controller),
      );

}