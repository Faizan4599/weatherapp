class FailedDataModel {
  String? cod;
  String? message;

  FailedDataModel({required this.cod, required this.message});

  factory FailedDataModel.fromJson(Map<String, String> json) =>
      FailedDataModel(cod: json["cod"], message: json["message"]);
}
