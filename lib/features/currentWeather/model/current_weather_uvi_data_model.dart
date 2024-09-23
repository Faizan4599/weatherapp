class CurrentWeatherUviDataModel {
  double? lat;
  double? lon;
  String? date_iso;
  int? date;
  double? value;
  CurrentWeatherUviDataModel({
    this.date,
    this.date_iso,
    this.lat,
    this.lon,
    this.value,
  });
  factory CurrentWeatherUviDataModel.fromJson(Map<String, dynamic> json) =>
      CurrentWeatherUviDataModel(
          date: json["date"] ?? 0,
          date_iso: json["date_iso"] ?? "",
          lat: json["lat"] ?? 0.0,
          lon: json["lon"] ?? 0.0,
          value: json["value"] ?? 0.0);
  String getUvDescription() {
    if (value != null) {
      if (value! < 3) {
        return "Very Weak";
      } else if (value! < 6) {
        return "Weak";
      } else if (value! < 8) {
        return "Moderate";
      } else if (value! < 11) {
        return "Strong";
      } else {
        return "Very Strong";
      }
    }
    return "Unknown";
  }
}
