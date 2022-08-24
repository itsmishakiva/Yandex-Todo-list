enum Flavor {
  DEV,
  PROD,
}

class F {
  static Flavor? appFlavor;

  static String get name => appFlavor?.name ?? '';

  static String get title {
    switch (appFlavor) {
      case Flavor.DEV:
        return 'DEV';
      case Flavor.PROD:
        return 'PROD';
      default:
        return 'title';
    }
  }

}
