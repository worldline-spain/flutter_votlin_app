enum Flavor { MOCK, LOCALHOST_EMULATOR }

class Config {
  static Flavor flavor;

  static String get EDD_HOST {
    switch (flavor) {
      case Flavor.LOCALHOST_EMULATOR:
        return "http://10.0.2.2:3000";
      case Flavor.MOCK:
      default:
        return "";
    }
  }
}
