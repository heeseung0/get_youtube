import 'package:flutter/material.dart';
import 'package:get_youtube/model/video_model.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CustomYoutubePlayer extends StatefulWidget {
  const CustomYoutubePlayer({
    super.key,
    required this.videoModel,
  });

  final VideoModel videoModel;

  @override
  State<CustomYoutubePlayer> createState() => _CustomYoutubePlayerState();
}

class _CustomYoutubePlayerState extends State<CustomYoutubePlayer> {
  YoutubePlayerController? controller;

  @override
  void initState() {
    super.initState();

    controller = YoutubePlayerController(
      initialVideoId: widget.videoModel.id, // 처음 실행할 동영상의 ID
      flags: const YoutubePlayerFlags(
        autoPlay: false, // 자동 실행 사용하지 않기, 기본값 : true
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // 유튜브 재생기 렌더링
        YoutubePlayer(
          controller: controller!,
          showVideoProgressIndicator: true, // 동영상 진행 사항을 알려주는 슬라이더
        ),
        const SizedBox(height: 16.0),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Text(
            widget.videoModel.title,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        const SizedBox(height: 16.0),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    controller!.dispose(); // State 폐기 시 컨트롤러도 같이 폐기 해야 함.
  }
}
