import 'package:dio/dio.dart';
import 'package:get_youtube/const/api.dart';
import 'package:get_youtube/model/video_model.dart';

/*
  해당 파일은 도대체 무슨 함수로 어떻게 구현 돼 있는지 잘 모르겠다.
 */

class YoutubeRepository {
  static Future<List<VideoModel>> getVideos() async {
    // 요청 방식이 바뀐 것 인지, key를 url 파라미터로 따로 넘겨 주어야 작동 함.
    // 보내는 get 요청은 같은데, 이상하게 작동 하지 않음. 이유는 모름.
    // 가저오는 json 형태 : https://developers.google.com/youtube/v3/docs/videos?hl=ko#resource
    final resp =
        await Dio().get('$YOUTUBE_API_BASE_URL?key=$API_KEY', queryParameters: {
      'channelId': CF_CHANNEL_ID,
      'maxResults': 100,
      //'key': API_KEY,
      'part': 'snippet',
      'order': 'date',
    });

    final listWithData = resp.data['items'].where(
      (item) =>
          item?['id']?['videoId'] != null && item?['snippet']?['title'] != null,
    );

    //이하 view count
    final List listData = resp.data['items']
        .where((item) =>
            item?['id']?['videoId'] != null &&
            item?['snippet']?['title'] != null)
        .toList();

    final List<String> videoIdList = [];

    listData.forEach((element) {
      videoIdList.add(element['id']['videoId']);
    });

    final statisticsList = await Dio()
        .get('$YOUTUBE_API_BASE_URL_VIDEO?key=$API_KEY', queryParameters: {
      'part': 'statistics',
      'id': videoIdList,
    });

    List<VideoModel> vmList = [];

    final List listStatisticsData = statisticsList.data['items']
        .where((item) =>
            item?['id'] != null && item?['statistics']?['viewCount'] != null)
        .toList();

    listData.forEach((snp) {
      listStatisticsData.forEach((sts) {
        if (sts['id'] == snp['id']['videoId']) {
          vmList.add(VideoModel(
            id: snp['id']['videoId'],
            title: snp['snippet']['title'],
            viewCount: sts['statistics']['viewCount'],
          ));
        }
      });
    });

    return vmList;
    //여기까지
    /*
    return listWithData
        .map<VideoModel>(
          (item) => VideoModel(
            id: item['id']['videoId'],
            title: item['snippet']['title'],
            //viewCount: item['statistics']['viewCount'],
          ),
        )
        .toList();
     */
  }
}
