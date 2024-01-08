import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/models/constants.dart';
import 'package:flutter_app/models/cities.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Constants myConstants = Constants();
//list of data taken from the api's
  List<double?> temperatures = List.filled(City.citiesList.length, null);
  List<double?> humidities = List.filled(City.citiesList.length, null);
  List<double?> windSpeeds = List.filled(City.citiesList.length, null);
  String datetime = '';

  //a list to store the cities/town names
  List<String> selectedCityNames = [];

  @override
  void initState() {
    super.initState();
    updateDateTime();
    fetchWeatherData(); //collects the weather data when called
  }

  void updateDateTime() {//method to set the time 
    final now = DateTime.now();
    final formattedDateTime = DateFormat('dd-MM-yyyy HH:mm:ss').format(now);// sets the date to show todays date and the time in digital format
    setState(() {
      datetime = formattedDateTime;
    });
  }

  Future<void> fetchWeatherData() async {//collects the weather data based on the city and its api
    for (City city in City.getSelectedCities()) {
      final response = await http.get(Uri.parse(city.apiLink));

      if (response.statusCode == 200) {
        //parse the data from the response
        final Map<String, dynamic> data = json.decode(response.body);

        //collects the data for each condition using a double so it call handle decimals
        final double? temperature = data['currentConditions']['temp'];
        final double? humidity = data['currentConditions']['humidity'];
        final double? windSpeed = data['currentConditions']['windspeed'];

        //updates the list
        setState(() {
          int index = City.citiesList.indexOf(city);
          temperatures[index] = temperature;
          humidities[index] = humidity; 
          windSpeeds[index] = windSpeed; 
          //print('Response for ${city.city}: ${response.body}'); testing tool
        });
      } else {
        //handle in case of errors
        print('Failed to fetch data for ${city.city}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    selectedCityNames = City.getSelectedCities().map((city) => city.city).toList();

    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          //stores the date at the top of the screen
          Container(
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: myConstants.lightprimaryColor, //sets the colour to match the colour scheme
            ),
            child: Text(
              datetime, //displays the time
              style: TextStyle(
                color: Colors.white, 
                fontSize: 20.0, 
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          //lists the selected cities/town
          Expanded(
            child: ListView.builder(
              itemCount: selectedCityNames.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    width: 150.0,
                    padding: const EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      border: City.citiesList[index].isSelected == true
                          ? Border.all(
                              color: myConstants.lightsecondaryColor.withOpacity(.6),
                              width: 2,
                            )
                          : Border.all(color: Colors.white),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: myConstants.lightprimaryColor.withOpacity(.2),
                          spreadRadius: 5,
                          blurRadius: 7,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          selectedCityNames[index],
                          style: TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),

                        //temperature box
                        Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.grey[300],
                          margin: EdgeInsets.only(bottom: 5),
                          child: Center(
                            child: Text(//takes the reading from the list and adds to its set box
                              'Temperature: ${temperatures[index]?.toString() ?? "N/A"} °F',//sets to N/A if it fails to find a reading
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        //humidity box
                        Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.grey[300],
                          margin: EdgeInsets.only(bottom: 5),
                          child: Center(
                            child: Text(
                              'Humidity: ${humidities[index]?.toString() ?? "N/A"}%',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        //wind speed box
                        Container(
                          height: 50,
                          width: double.infinity,
                          color: Colors.grey[300],
                          margin: EdgeInsets.only(bottom: 5),
                          child: Center(
                            child: Text(
                              'Wind Speed: ${windSpeeds[index]?.toString() ?? "N/A"} mph',
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
