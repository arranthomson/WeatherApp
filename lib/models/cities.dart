import 'package:flutter_app/models/api.dart';

class City { //city class represents the city or town the user can select in the app
  final String city; //name of the city/town
  bool isSelected; //is it selected?
  final String apiLink;//its API link
  final bool isDefault;//does it come selected by default

  City({ //initializer for the city object
    required this.city,
    required this.isSelected,
    required this.apiLink,
    required this.isDefault,
  });

  static List<City> citiesList = [ // list of all the cities/towns with their properties such as: are they selected?, what is their API link? etc.
    City(city: 'London', isSelected: true, apiLink: VisualCrossingApiKeys.london, isDefault: true),//london comes selected by default which is why it set to true
    City(city: 'Manchester', isSelected: false, apiLink: VisualCrossingApiKeys.manchester, isDefault: false),//other cities/towns are set to false so the user can pick from them
    City(city: 'Birmingham', isSelected: false, apiLink: VisualCrossingApiKeys.birmingham, isDefault: false),
    City(city: 'Leeds', isSelected: false, apiLink: VisualCrossingApiKeys.leeds, isDefault: false),
    City(city: 'Bradford', isSelected: false, apiLink: VisualCrossingApiKeys.bradford, isDefault: false),
    City(city: 'Glasgow', isSelected: false, apiLink: VisualCrossingApiKeys.glasgow, isDefault: false),
    City(city: 'Southampton', isSelected: false, apiLink: VisualCrossingApiKeys.southampton, isDefault: false),
    City(city: 'Portsmouth', isSelected: false, apiLink: VisualCrossingApiKeys.portsmouth, isDefault: false),
    City(city: 'Liverpool', isSelected: false, apiLink: VisualCrossingApiKeys.liverpool, isDefault: false),
    City(city: 'Newcastle', isSelected: false, apiLink: VisualCrossingApiKeys.newcastle, isDefault: false),
    City(city: 'Nottingham', isSelected: false, apiLink: VisualCrossingApiKeys.nottingham, isDefault: false),
    City(city: 'Sheffield', isSelected: false, apiLink: VisualCrossingApiKeys.sheffield, isDefault: false),
    City(city: 'Bristol', isSelected: false, apiLink: VisualCrossingApiKeys.bristol, isDefault: false),
    City(city: 'Belfast', isSelected: false, apiLink: VisualCrossingApiKeys.belfast, isDefault: false),
    City(city: 'Leicester', isSelected: false, apiLink: VisualCrossingApiKeys.leicester, isDefault: false),
    City(city: 'Edinburgh', isSelected: false, apiLink: VisualCrossingApiKeys.edinburgh, isDefault: false),
    City(city: 'Bournemouth', isSelected: false, apiLink: VisualCrossingApiKeys.bournemouth, isDefault: false),
    City(city: 'Cardiff', isSelected: false, apiLink: VisualCrossingApiKeys.cardiff, isDefault: false),
    City(city: 'Coventry', isSelected: false, apiLink: VisualCrossingApiKeys.coventry, isDefault: false),
    City(city: 'Middlesbrough', isSelected: false, apiLink: VisualCrossingApiKeys.middlesbrough, isDefault: false),
    City(city: 'Stoke', isSelected: false, apiLink: VisualCrossingApiKeys.stoke, isDefault: false),
    City(city: 'Blackpool', isSelected: false, apiLink: VisualCrossingApiKeys.blackpool, isDefault: false),
  ];

  static List<City> getSelectedCities() {//gets the list of selected cities are returns the value
    return citiesList.where((city) => city.isSelected).toList();
  }

  static List<String> getSelectedCityNames() {//gets the name of the cities and returns them
    List<City> selectedCities = getSelectedCities();
    return selectedCities.map((city) => city.city).toList();
  }
}