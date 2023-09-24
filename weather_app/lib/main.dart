import 'package:flutter/material.dart';
import 'package:weather_app/data_service.dart';
import 'package:weather_app/json_model.dart';
import 'package:weather_app/calculator.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(useMaterial3: true),
      debugShowCheckedModeBanner: false,
      home: MainPage(),
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});
  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {

  final _cityTextController = TextEditingController(); // Text Editor

  final DataService _dataService = DataService(); // DataService object

  WeatherResponse? _response; // Nullable WeatherResponse object

  //Set default city to San Diego
  @override
  void initState() {
    super.initState();
    _defsearch("San Diego");
  }
  @override
  Widget build(BuildContext context) {


  
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layth\'s Weather App'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.sunny), label: 'Weather'),
          BottomNavigationBarItem(icon: Icon(Icons.calculate), label: 'Calculator'),
        ],
        onTap: (index) {
           
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Calculator()),
          );
        },
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (_response != null) // Check if _response is not null
              Column(
                children: [
                  Text(
                    _response!.cityName,
                    style: const TextStyle(
                        fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  Image.network(
                    _response!.iconUrl,
                    scale: .4,
                  ),
                  Text(
                    '${_response!.tempInfo.temperature}°F',
                    style: const TextStyle(fontSize: 40),
                  ),
                  Text(_response!.weatherInfo.description),
                ],
              ),
            SizedBox(
              width: 150,
              child: TextField(
                controller: _cityTextController,
                decoration: const InputDecoration(labelText: 'City'),
                textAlign: TextAlign.center,
              ),
            ),
            ElevatedButton(
              onPressed: _search,
              style: ElevatedButton.styleFrom(
                primary: const Color.fromARGB(255, 83, 8, 96),
                onPrimary: Colors.white,
                onSurface: Colors.grey,
              ),
              child: const Text('Search'),
            ),
            if (_response !=
                null) // If the reponse isn't null display more forecase button
              TextButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.white,
                  onPrimary: const Color.fromARGB(255, 83, 8, 96),
                  onSurface: Colors.white,
                ),
                child: const Text('More Forecast Details'),
                onPressed: () {
                  showModalBottomSheet(
                      context: context,
                      builder: (BuildContext context) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ListTile(
                                title: Text(
                                    'Max Temp: ${_response!.tempInfo.tempMax}')),
                             ListTile(
                                 title: Text(
                                     'Min Temp: ${_response!.tempInfo.tempMin}')),
                            ListTile(
                                title: Text(
                                    'Coordinates: ${_response!.coordInfo.longitude}°N ${_response!.coordInfo.latitude}°E')),
                            ListTile(
                                title: Text(
                                    'Sunrise: ${_response!.sysInfo.sunrise}')),
                            ListTile(
                                title: Text(
                                    'Sunset: ${_response!.sysInfo.sunset}')),
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('Close')),
                          ],
                        );
                      });
                },
              ),
          ],
        ),
      ),
    );
  }

  // Search function for weather when button pressed, sets _response to the response from the API
  void _search() async {
    final response = await _dataService.getWeather(_cityTextController.text);
    setState(() {
      _response = response;
    });
  }
  // Manual search function for weather 
  void _defsearch(String defaultCity) async {
    final response = await _dataService.getWeather(defaultCity);
    setState(() {
      _response = response;
    });
  }
}
