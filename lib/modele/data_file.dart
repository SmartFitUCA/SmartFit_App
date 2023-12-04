class DataFile {
  final List<List<String>> csvData;
  final String category;
  final String startTime;
  final double denivelePositif;
  final double deniveleNegatif;

  DataFile(this.csvData, this.category, this.startTime, this.denivelePositif,
      this.deniveleNegatif);
}
