import 'dart:convert';

WeatherModel weatherModelFromJson(String str) =>
    WeatherModel.fromJson(json.decode(str));

String weatherModelToJson(WeatherModel data) => json.encode(data.toJson());

class WeatherModel {
  double? latitude;
  double? longitude;
  double? generationtimeMs;
  int? utcOffsetSeconds;
  String? timezone;
  String? timezoneAbbreviation;
  double? elevation;
  CurrentUnits? currentUnits;
  Current? current;
  DailyUnits? dailyUnits;
  Daily? daily;

  WeatherModel({
    this.latitude,
    this.longitude,
    this.generationtimeMs,
    this.utcOffsetSeconds,
    this.timezone,
    this.timezoneAbbreviation,
    this.elevation,
    this.currentUnits,
    this.current,
    this.dailyUnits,
    this.daily,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        latitude: json["latitude"]?.toDouble(),
        longitude: json["longitude"]?.toDouble(),
        generationtimeMs: json["generationtime_ms"]?.toDouble(),
        utcOffsetSeconds: json["utc_offset_seconds"],
        timezone: json["timezone"],
        timezoneAbbreviation: json["timezone_abbreviation"],
        elevation: json["elevation"],
        currentUnits: json["current_units"] == null
            ? null
            : CurrentUnits.fromJson(json["current_units"]),
        current:
            json["current"] == null ? null : Current.fromJson(json["current"]),
        dailyUnits: json["daily_units"] == null
            ? null
            : DailyUnits.fromJson(json["daily_units"]),
        daily: json["daily"] == null ? null : Daily.fromJson(json["daily"]),
      );

  Map<String, dynamic> toJson() => {
        "latitude": latitude,
        "longitude": longitude,
        "generationtime_ms": generationtimeMs,
        "utc_offset_seconds": utcOffsetSeconds,
        "timezone": timezone,
        "timezone_abbreviation": timezoneAbbreviation,
        "elevation": elevation,
        "current_units": currentUnits?.toJson(),
        "current": current?.toJson(),
        "daily_units": dailyUnits?.toJson(),
        "daily": daily?.toJson(),
      };
}

class Current {
  String? time;
  int? interval;
  double? temperature2M;
  int? weathercode;

  Current({this.time, this.interval, this.temperature2M, this.weathercode});

  factory Current.fromJson(Map<String, dynamic> json) => Current(
        time: json["time"],
        interval: json["interval"],
        temperature2M: json["temperature_2m"]?.toDouble(),
        weathercode: json["weathercode"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "interval": interval,
        "temperature_2m": temperature2M,
      };
}

class CurrentUnits {
  String? time;
  String? interval;
  String? temperature2M;

  CurrentUnits({
    this.time,
    this.interval,
    this.temperature2M,
  });

  factory CurrentUnits.fromJson(Map<String, dynamic> json) => CurrentUnits(
        time: json["time"],
        interval: json["interval"],
        temperature2M: json["temperature_2m"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "interval": interval,
        "temperature_2m": temperature2M,
      };
}

class Daily {
  List<DateTime>? time;
  List<int>? weathercode;
  List<double>? temperature2MMax;
  List<double>? temperature2MMin;
  List<String>? sunrise;
  List<String>? sunset;

  Daily({
    this.time,
    this.weathercode,
    this.temperature2MMax,
    this.temperature2MMin,
    this.sunrise,
    this.sunset,
  });

  factory Daily.fromJson(Map<String, dynamic> json) => Daily(
        time: json["time"] == null
            ? []
            : List<DateTime>.from(json["time"]!.map((x) => DateTime.parse(x))),
        weathercode: json["weathercode"] == null
            ? []
            : List<int>.from(json["weathercode"]!.map((x) => x)),
        temperature2MMax: json["temperature_2m_max"] == null
            ? []
            : List<double>.from(
                json["temperature_2m_max"]!.map((x) => x?.toDouble())),
        temperature2MMin: json["temperature_2m_min"] == null
            ? []
            : List<double>.from(
                json["temperature_2m_min"]!.map((x) => x?.toDouble())),
        sunrise: json["sunrise"] == null
            ? []
            : List<String>.from(json["sunrise"]!.map((x) => x)),
        sunset: json["sunset"] == null
            ? []
            : List<String>.from(json["sunset"]!.map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "time": time == null
            ? []
            : List<dynamic>.from(time!.map((x) =>
                "${x.year.toString().padLeft(4, '0')}-${x.month.toString().padLeft(2, '0')}-${x.day.toString().padLeft(2, '0')}")),
        "weathercode": weathercode == null
            ? []
            : List<dynamic>.from(weathercode!.map((x) => x)),
        "temperature_2m_max": temperature2MMax == null
            ? []
            : List<dynamic>.from(temperature2MMax!.map((x) => x)),
        "temperature_2m_min": temperature2MMin == null
            ? []
            : List<dynamic>.from(temperature2MMin!.map((x) => x)),
        "sunrise":
            sunrise == null ? [] : List<dynamic>.from(sunrise!.map((x) => x)),
        "sunset":
            sunset == null ? [] : List<dynamic>.from(sunset!.map((x) => x)),
      };
}

class DailyUnits {
  String? time;
  String? weathercode;
  String? temperature2MMax;
  String? temperature2MMin;
  String? sunrise;
  String? sunset;

  DailyUnits({
    this.time,
    this.weathercode,
    this.temperature2MMax,
    this.temperature2MMin,
    this.sunrise,
    this.sunset,
  });

  factory DailyUnits.fromJson(Map<String, dynamic> json) => DailyUnits(
        time: json["time"],
        weathercode: json["weathercode"],
        temperature2MMax: json["temperature_2m_max"],
        temperature2MMin: json["temperature_2m_min"],
        sunrise: json["sunrise"],
        sunset: json["sunset"],
      );

  Map<String, dynamic> toJson() => {
        "time": time,
        "weathercode": weathercode,
        "temperature_2m_max": temperature2MMax,
        "temperature_2m_min": temperature2MMin,
        "sunrise": sunrise,
        "sunset": sunset,
      };
}
