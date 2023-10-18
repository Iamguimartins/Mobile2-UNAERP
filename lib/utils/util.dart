class Util {

  static bool existStringInList(List<String> list, String value) {
    return list.indexWhere((s) => s == value) >= 0;
  }
}