import 'package:flutter/material.dart';
import 'package:flutter_app/models/cities.dart';
import 'package:flutter_app/models/constants.dart';
import 'package:flutter_app/ui/home.dart';


class Welcome extends StatefulWidget { //welcome screen with all the posible cities/towns that the user can select
  const Welcome({Key? key}) : super(key: key);

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) { //filters the default cities/towns e.g.: london
    List<City> cities = City.citiesList.where((city) => city.isDefault == false).toList();
    List<City> selectedCities = City.getSelectedCities();

    Constants myConstants = Constants(); //calls the constant to then use to keep the colour scheme the same
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: myConstants.lightsecondaryColor, //list of the cites/towns
        title: Text(selectedCities.length.toString() + ' selected'),
      ),
      body: ListView.builder(
        itemCount: cities.length,
        itemBuilder: (BuildContext context, int index) {
          return Container( //container for the styling 
            margin: const EdgeInsets.only(left: 10, top: 20, right: 10),
            padding: const EdgeInsets.symmetric(horizontal: 20),
            height: size.height * 0.2, 
            width: size.width,
            decoration: BoxDecoration(
              border: cities[index].isSelected == true
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
                )
              ],
            ),
            child: Row(
              children: [
                GestureDetector(//toggle for if the city is selected
                  onTap: (){
                    setState(() {
                      cities[index].isSelected =! cities[index].isSelected;   
                                        });
                  },
                  child: Image.asset(
                    cities[index].isSelected == true
                        ? 'assets/tick-icon.png'//displays a tick or an empty box depending on if the user has selected it.
                        : 'assets/unchecked-box.png',
                    width: 30,
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(//displays the name
                  cities[index].city,
                  style: TextStyle(
                      fontSize: 16,
                      color: cities[index].isSelected == true
                          ? myConstants.lightprimaryColor
                          : Colors.black54),
                )
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(//navigation to the home page
        backgroundColor: myConstants.lightsecondaryColor,
        child: const Icon(Icons.pin_drop),
        onPressed: (){
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Home()));
        },
      ),
    );
  }
}
