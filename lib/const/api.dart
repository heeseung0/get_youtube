// 이거 오류나면 gcp에서 YouTube Data API v3 사용을 설정 안해서 그럼
const API_KEY = 'AIzaSyAp6_qMtnTEO0ZWforle1dLskU-dhJj57Q'; // GCP에서 발급받은 토큰

/*
  Youtube Data API V3
    해당 앱에선 Search:list Api를 사용 하여
    특정 채널에서, 다수의 동영상을, 최신 순서대로 불러온다.

    Search:list API의 정의
      key : GCP에서 발급받은 키값
      part : 어떤 정보를 불러올지 정의. Search:list는 snippet만 사용 가능
        snippet? 썸네일, ID와 같은 다수의 부가 정보를 추가해준다.
      channelId : 동영상을 불러올 대상 채널의 ID이다. 여기선 CF_CHANNEL_ID로 사용 중.
      maxResults : 최대로 가져올 결과값 개수.

    위 테이블을 기반으로 HTTP 요청을 보내면 성공하면 JSON 데이터를, 실패하면 ERROR를 리턴받는다.
 */

const YOUTUBE_API_BASE_URL = 'https://youtube.googleapis.com/youtube/v3/search';
const YOUTUBE_API_BASE_URL_VIDEO =
    'https://youtube.googleapis.com/youtube/v3/videos';
// https://ytubetool.com/ko/tools/youtube-channel-id?u=kimjimintv
// 입질의 추억 채널만 들고오도록 설정
const channel_name = '입질의 추억';
const CF_CHANNEL_ID = 'UCY2uWQDCzn_ZE-JpTfDRR2A';
