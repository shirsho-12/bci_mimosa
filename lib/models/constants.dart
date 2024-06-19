class Constants {
  static List<int> durationsInSeconds = [
    0, // start
    2, // scale up
    4, // rotate
    2, // half-open bag
    2, // open bag
  ];

  static int initDuration = 10;
  static int gameDuration = 32;
  static int maxLevel = 3;
  static int transitionDuration = 4;
  static int imageDuration = 5;
  static double transitionWeight =
      transitionDuration / (transitionDuration + imageDuration);
  static double imageWeight =
      imageDuration / (transitionDuration + imageDuration);

  static int lowRisk = 3;
  static int mediumRisk = 8;
}
