class DD {
  // 将小于10的数字前缀0后返回
  static String execNumber(int x) {
    if (x < 10)
      return "0$x";
    else {
      return "$x";
    }
  }
}
