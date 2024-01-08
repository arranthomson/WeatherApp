import 'package:flutter/material.dart';
import 'package:flutter_app/models/constants.dart';
import 'package:flutter_app/ui/welcome.dart';
class GetStarted extends StatelessWidget {
  const GetStarted({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Constants myConstants = Constants();

    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        width: size.width,
        height: size.height,
        color: myConstants.lightprimaryColor.withOpacity(.5),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, //aligns the logo and button in the centre of the screen
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Image.asset('assets/AppLogo4.png', fit: BoxFit.contain),//displays the logo
              ),
              const SizedBox(height: 30,),
              GestureDetector(
                onTap: (){//button to move to the welcome tab
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> const Welcome()));
                },
                child: Container(
                  height: 50,
                  width: size.width * 0.7,
                  decoration: BoxDecoration(
                    color: myConstants.lightprimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(18)),
                  ),
                  child: const Center(
                    child: Text('Get Started', style: TextStyle(color: Colors.white, fontSize: 18),),//text for button
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
