import 'package:flutter/material.dart';
import 'package:get_youtube/component/custom_youtube_player.dart';
import 'package:get_youtube/model/video_model.dart';
import 'package:get_youtube/repository/youtube_repository.dart';

import '../const/api.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          '[$channel_name] 유튜브 Get',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
          ),
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<VideoModel>>(
        future: YoutubeRepository.getVideos(),
        builder: (context, snapshot) {
          // 에러가 있을 경우 화면에 에러 내용 표시
          if (snapshot.hasError) {
            print(snapshot.error);
            return Center(
              child: Text(
                snapshot.error.toString(),
              ),
            );
          }
          if (!snapshot.hasData) {
            // 로딩 중일 때 로딩 위젯
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            // 아래로 당겨서 스크롤할 때 튕기는 애니메이션 추가
            physics: const BouncingScrollPhysics(),
            children: snapshot.data!
                .map((e) => CustomYoutubePlayer(videoModel: e))
                .toList(),
          );
        },
      ),
    );
  }
}
