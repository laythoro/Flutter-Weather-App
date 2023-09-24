import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:weather_app/json_model.dart';


class DataService{

  Future<WeatherResponse> getWeather(String city) async{
    
    //https://api.openweathermap.org/data/2.5/weather?q={city name}&appid={API key}

    final queryParameters = {'q': city, 'appid': 'a6f1bbd28c0153cf4521d65b6c7818d6', 'units': 'imperial'};

    final uri = Uri.https('api.openweathermap.org', '/data/2.5/weather', queryParameters);

    final response = await http.get(uri);

    final json = jsonDecode(response.body);

    return WeatherResponse.fromJson(json);
  }
}