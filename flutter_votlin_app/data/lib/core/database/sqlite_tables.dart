class SqliteTables {
  static const String _TABLE_TALKS_RATING = "CREATE TABLE TalkRatings" +
      "(" +
      "talkId INTEGER PRIMARY KEY," +
      "value REAL" +
      ")";

  static List<String> getCreateTables() {
    return [_TABLE_TALKS_RATING];
  }
}
