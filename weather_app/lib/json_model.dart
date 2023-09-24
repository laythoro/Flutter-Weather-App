/*
{
  "coord": {
    "lon": 10.99,
    "lat": 44.34
  },
  "weather": [
    {
      "id": 501,
      "main": "Rain",
      "description": "moderate rain",
      "icon": "10d"
    }
  ],
  "base": "stations",
  "main": {
    "temp": 298.48,
    "feels_like": 298.74,
    "temp_min": 297.56,
    "temp_max": 300.05,
    "pressure": 1015,
    "humidity": 64,
    "sea_level": 1015,
    "grnd_level": 933
  },
  "visibility": 10000,
  "wind": {
    "speed": 0.62,
    "deg": 349,
    "gust": 1.18
  },
  "rain": {
    "1h": 3.16
  },
  "clouds": {
    "all": 100
  },
  "dt": 1661870592,
  "sys": {
    "type": 2,
    "id": 2075663,
    "country": "IT",
    "sunrise": 1661834187,
    "sunset": 1661882248
  },
  "timezone": 7200,
  "id": 3163858,
  "name": "Zocca",
  "cod": 200
}      
*/
import 'package:intl/intl.dart';

class WeatherInfo {

  final String description;
  final String icon;

  WeatherInfo({required this.description, required this.icon});

  factory WeatherInfo.fromJson(Map<String, dynamic> json) {
    // Parses an object of this type
    // "weather": [
    // {
    //   "id": 501,
    //   "main": "Rain",
    //   "description": "moderate rain",
    //   "icon": "10d"
    // }
    final description = json['description'];
    final icon = json['icon'];
    return WeatherInfo(description: description, icon: icon,);
  }
}

//Currently has tempMin rempved
class TemperatureInfo {
  final double temperature;
  final double tempMin;
  final double tempMax;

  TemperatureInfo({required this.temperature, required this.tempMin, required this.tempMax});

  factory TemperatureInfo.fromJson(Map<String, dynamic> json) {
    final double temperature = json['temp'];
    final double tempMin = json['temp_min'];
    final double tempMax = json['temp_max'];

    return TemperatureInfo(temperature: temperature, tempMin: tempMin, tempMax: tempMax);
  }
}

class CoordInfo {
  final double longitude;
  final double latitude;

  CoordInfo({required this.longitude, required this.latitude});

  factory CoordInfo.fromJson(Map<String, dynamic> json){
    final double longitude = json['lon'].toDouble();
    final double latitude = json['lat'].toDouble();

    return CoordInfo(longitude: longitude, latitude: latitude);
  }
}

class SysInfo{
  final String sunrise;
  final String sunset;

  SysInfo({required this.sunrise, required this.sunset});

  factory SysInfo.fromJSon(Map<String, dynamic> json){
    DateTime dateTimeUtc = DateTime.fromMillisecondsSinceEpoch(json['sunrise'] * 1000);
    final String sunrise = DateFormat('kk:mm:ss').format(dateTimeUtc);
    dateTimeUtc = DateTime.fromMillisecondsSinceEpoch(json['sunset'] * 1000);
    final String sunset = DateFormat('kk:mm:ss').format(dateTimeUtc);;
    
    
    return SysInfo(sunrise: sunrise, sunset: sunset);
  }
}

class WeatherResponse {
  final String cityName;
  final TemperatureInfo tempInfo;
  final WeatherInfo weatherInfo;
  final CoordInfo coordInfo;
  final SysInfo sysInfo;

  String get iconUrl {
    return 'https://openweathermap.org/img/w/${weatherInfo.icon}.png';
  }

  WeatherResponse({required this.cityName, required this.tempInfo, required this.weatherInfo, required this.coordInfo, required this.sysInfo});

  factory WeatherResponse.fromJson(Map<String, dynamic> json) {
    final cityName = json['name'];

    final tempInfoJson = json['main'];
    final tempInfo = TemperatureInfo.fromJson(tempInfoJson);

    final weatherInfoJson = json['weather'][0];
    final weatherInfo = WeatherInfo.fromJson(weatherInfoJson);

    final coordInfoJson = json['coord'];
    final coordInfo = CoordInfo.fromJson(coordInfoJson);

    final sysInfoJson = json['sys'];
    final sysInfo = SysInfo.fromJSon(sysInfoJson);

    
    return WeatherResponse(cityName: cityName, tempInfo: tempInfo, weatherInfo: weatherInfo, coordInfo: coordInfo, sysInfo: sysInfo);
  }
}