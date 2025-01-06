class RTNAudio {
  static const String basePath = 'audio/';
  static const String rtnPath = 'audio/rtn/';

  static const String lookAtThis = '${rtnPath}look_at_this.wav';
  static const String lookAtThat = '${rtnPath}look_at_that.wav';

  static const String start = '${rtnPath}start_audio.wav';
  static const String hello = '${basePath}hello.wav';
  static const String goodbye = '${basePath}see_you.wav';
  static const String wow = '${rtnPath}wow.wav';

  static const List<String> look = [lookAtThis, lookAtThat];

  static const List<String> items = [
    '${rtnPath}bird.wav',
    '${rtnPath}butterfly.wav',
    '${rtnPath}rabbit.wav',
    '${rtnPath}snail.wav',
  ];
}

class FacePrefAudio {
  static const String basePath = 'audio';
  static const String facePrefPath = '$basePath/face_pref';

  static const String bounce = '$facePrefPath/bounce.wav';
  static const String seeInside = '$facePrefPath/see_inside.wav';
  static const String makeFriends = '$facePrefPath/make_friends.wav';

  static const String start = '$facePrefPath/start_audio.wav';
  static const String hello = '$basePath/hello.wav';
  static const String clap = '$basePath/clap.wav';
  static const String goodbye = '$basePath/see_you.wav';
}
