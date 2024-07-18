class FacePrefAssets {
  static List<String> transitionAnimationImages = [
    'assets/images/face_pref/secondlayer_bag1.png',
    'assets/images/face_pref/secondlayer_bag2.png',
    'assets/images/face_pref/secondlayer_bag3.png',
  ];

  static String bagImage = 'assets/images/face_pref/closedbag.png';

  static List<String> bagOpeningImages = [
    'assets/images/face_pref/half_open_bag1.png',
    'assets/images/face_pref/half_open_bag2.png',
  ];

  static List<String> levelOneImages = [
    'assets/images/face_pref/level_1/v1.png',
    'assets/images/face_pref/level_1/v1b.png',
    'assets/images/face_pref/level_1/v2.png',
    'assets/images/face_pref/level_1/v2b.png'
  ];

  static List<String> levelTwoImagesM = [
    'assets/images/face_pref/level_2/M1.png',
    'assets/images/face_pref/level_2/M2.png',
    'assets/images/face_pref/level_2/M3.png',
    'assets/images/face_pref/level_2/M4.png',
  ];

  static List<String> levelTwoImagesF = [
    'assets/images/face_pref/level_2/F1.png',
    'assets/images/face_pref/level_2/F2.png',
    'assets/images/face_pref/level_2/F3.png',
    'assets/images/face_pref/level_2/F4.png',
  ];

  static List<String> levelThreeImagesM = [
    'assets/images/face_pref/level_3/M1.png',
    'assets/images/face_pref/level_3/M2.png',
    'assets/images/face_pref/level_3/M3.png',
    'assets/images/face_pref/level_3/M4.png',
    'assets/images/face_pref/level_3/M5.png',
    'assets/images/face_pref/level_3/M6.png',
    'assets/images/face_pref/level_3/M7.png',
    'assets/images/face_pref/level_3/M8.png'
  ];

  static List<String> levelThreeImagesF = [
    'assets/images/face_pref/level_3/F1.png',
    'assets/images/face_pref/level_3/F2.png',
    'assets/images/face_pref/level_3/F3.png',
    'assets/images/face_pref/level_3/F4.png',
    'assets/images/face_pref/level_3/F5.png',
    'assets/images/face_pref/level_3/F6.png',
    'assets/images/face_pref/level_3/F7.png',
    'assets/images/face_pref/level_3/F8.png'
  ];

  static List<String> balloonImages = [
    'assets/images/face_pref/bag_balloon1.png',
    'assets/images/face_pref/bag_balloon2.png',
  ];
}

class RTNAssets {
  int level = 1;
  String gender = 'm';
  late List<String> moveImages;
  late List<String> gazeImages;
  late List<String> pointImages;
  late List<String> distractors;

  RTNAssets(this.level, this.gender) {
    moveImages = [
      'assets/images/rtn_gp/level_$level/$gender/walk.png',
      'assets/images/rtn_gp/level_$level/$gender/walk2.png',
      'assets/images/rtn_gp/level_$level/$gender/talk.png',
      'assets/images/rtn_gp/level_$level/$gender/wow.png',
    ];

    pointImages = [
      'assets/images/rtn_gp/level_$level/$gender/point/bird.png',
      'assets/images/rtn_gp/level_$level/$gender/point/butterfly.png',
      'assets/images/rtn_gp/level_$level/$gender/point/cloud.png',
      'assets/images/rtn_gp/level_$level/$gender/point/flower.png',
      'assets/images/rtn_gp/level_$level/$gender/point/rabbit.png',
      'assets/images/rtn_gp/level_$level/$gender/point/snail.png',
    ];

    distractors = [
      'assets/images/rtn_gp/distractor12.png',
      'assets/images/rtn_gp/distractor8.png',
    ];
  }

  static final List<String> backgroundImages = [
    'assets/images/rtn_gp/bg1.png',
    'assets/images/rtn_gp/bg2.png',
  ];

// Indexing: 0: walk right, 1: walk left, 2: talk, 3: wow
}
