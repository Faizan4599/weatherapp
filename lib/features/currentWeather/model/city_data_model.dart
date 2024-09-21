class CityDataModel {
  bool isSelected;
  final String city;
  final String country;
  final bool isDefault;
  CityDataModel(
      {required this.city,
      required this.country,
      required this.isDefault,
      required this.isSelected});
  static List<CityDataModel> cityList = [
    CityDataModel(
        isSelected: true, isDefault: false, city: 'Delhi', country: 'India'),
    CityDataModel(
        isSelected: false, isDefault: false, city: 'New York', country: 'USA'),
    CityDataModel(
        isSelected: false, isDefault: false, city: 'Tokyo', country: 'Japan'),
    CityDataModel(
        isSelected: false, isDefault: false, city: 'London', country: 'UK'),
    CityDataModel(
        isSelected: false, isDefault: false, city: 'Paris', country: 'France'),
    CityDataModel(
        isSelected: false,
        isDefault: false,
        city: 'Berlin',
        country: 'Germany'),
  ];

  static List<CityDataModel> getSelectedCites() {
    List<CityDataModel> selectedCities = CityDataModel.cityList;
    return selectedCities
        .where(
          (city) => city.isSelected == true,
        )
        .toList();
  }
}
