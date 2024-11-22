import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(const WeatherApp());
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Weather App',
      theme: ThemeData(
        primarySwatch: Colors.pink,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();
  String _weatherInfo = '';
  String _errorMessage = '';
  bool _isLoading = false;
  String _temperature = '';
  String _iconUrl = '';

  Future<void> _getWeather() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _temperature = '';
      _iconUrl = '';
    });

    final city = _controller.text.trim();
    if (city.isEmpty) {
      setState(() {
        _errorMessage = 'Просто так нажимать на кнопочку не нужно)) Пожалуйста, введите название города.';
        _isLoading = false;
      });
      return;
    }

    final apiKey = '';
    final url =
        'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=$apiKey&units=metric';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final iconCode = data['weather'][0]['icon'];
        final temp = data['main']['temp'];
        setState(() {
          _iconUrl = 'http://openweathermap.org/img/wn/$iconCode.png';
          _temperature = '$temp °C';
          _errorMessage = '';
        });
      } else {
        setState(() {
          _errorMessage = 'Город не найден!';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'Ошибка при получении данных.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.pinkAccent,
        appBar: AppBar(
          title: Center(
            child: const Text(
              'Узнай погоду!',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        body: Column(
            children: [
            if (_isLoading) CircularProgressIndicator(),
    Spacer(),
    Column(
    children: [
    if (_iconUrl.isNotEmpty)
    Image.network(_iconUrl)
    else
    Image.asset('assets/images/images.jpeg'),

    Text(
    _temperature,
    style: const TextStyle(fontSize: 48),
    textAlign: TextAlign.center,
    ),
      const SizedBox(height: 20),
      Text(
        _errorMessage,
        style: const TextStyle(color: Colors.white, fontSize: 24),
      ),
    ],
    ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Жду, когда ты введёшь сюда название города..',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              ElevatedButton(
                onPressed: _getWeather,
                child: const Text('Получить погоду'),
              ),
            ],
        ),
    );
  }
}
