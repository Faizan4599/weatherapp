class ItemMo {
  String? cod;
  int? message;
  int? cnt;
  List<ListElement>? list;
  City? city;

  ItemMo({
    this.cod,
    this.message,
    this.cnt,
    this.list,
    this.city,
  });
}

class City {
  int? id;
  String? name;
  Coord? coord;
  String? country;
  int? population;
  int? timezone;
  int? sunrise;
  int? sunset;

  City({
    this.id,
    this.name,
    this.coord,
    this.country,
    this.population,
    this.timezone,
    this.sunrise,
    this.sunset,
  });
}

class Coord {
  double? lat;
  double? lon;

  Coord({
    this.lat,
    this.lon,
  });
}

class ListElement {
  int? dt;
  MainClass? main;
  List<Weather>? weather;
  Clouds? clouds;
  Wind? wind;
  int? visibility;
  double? pop;
  Rain? rain;
  Sys? sys;
  DateTime? dtTxt;

  ListElement({
    this.dt,
    this.main,
    this.weather,
    this.clouds,
    this.wind,
    this.visibility,
    this.pop,
    this.rain,
    this.sys,
    this.dtTxt,
  });
}

class Clouds {
  int? all;

  Clouds({
    this.all,
  });
}

class MainClass {
  double? temp;
  double? feelsLike;
  double? tempMin;
  double? tempMax;
  int? pressure;
  int? seaLevel;
  int? grndLevel;
  int? humidity;
  double? tempKf;

  MainClass({
    this.temp,
    this.feelsLike,
    this.tempMin,
    this.tempMax,
    this.pressure,
    this.seaLevel,
    this.grndLevel,
    this.humidity,
    this.tempKf,
  });
}

class Rain {
  double? the3H;

  Rain({
    this.the3H,
  });
}

class Sys {
  Pod? pod;

  Sys({
    this.pod,
  });
}

enum Pod { D, N }

class Weather {
  int? id;
  MainEnum? main;
  Description? description;
  Icon? icon;

  Weather({
    this.id,
    this.main,
    this.description,
    this.icon,
  });
}

enum Description {
  HEAVY_INTENSITY_RAIN,
  LIGHT_RAIN,
  MODERATE_RAIN,
  OVERCAST_CLOUDS
}

enum Icon { THE_04_D, THE_04_N, THE_10_D, THE_10_N }

enum MainEnum { CLOUDS, RAIN }

class Wind {
  double? speed;
  int? deg;
  double? gust;

  Wind({
    this.speed,
    this.deg,
    this.gust,
  });
}
