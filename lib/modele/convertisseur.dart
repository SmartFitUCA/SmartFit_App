class Convertisseur {
  // Mettre que des trucs static

  static double secondeIntoMinute(double seconde) {
    return (seconde / 60);
  }

  static double milisecondeIntoMinute(double miliseconde) {
    return (miliseconde / 60000);
  }

  static double msIntoKmh(double metreSeconde) {
    return metreSeconde * 3.6;
  }

  static double millisecondeIntoSeconde(double milliseconde) {
    return (milliseconde / 1000);
  }
}
