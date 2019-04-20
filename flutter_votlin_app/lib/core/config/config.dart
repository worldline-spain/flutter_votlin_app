enum Flavor { MOCK, LOCALHOST_EMULATOR, MOCK_WEBSERVER, PLATFORM }

class Config {
  static Flavor flavor;

  static String get EDD_HOST {
    switch (flavor) {
      case Flavor.LOCALHOST_EMULATOR:
        return "http://10.0.2.2:3000";
      case Flavor.MOCK_WEBSERVER:
        return "http://127.0.0.1:8081";
      case Flavor.MOCK:
      case Flavor.PLATFORM:
      default:
        return "";
    }
  }
}
