import 'package:flutter/material.dart';
import 'package:flutter_app/ui/get_started.dart';
void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget{
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context){ //creates container for the application and gives it a title
    return const MaterialApp( 
      title: 'Climate Adviser',
      home: GetStarted(),
      debugShowCheckedModeBanner: false,
    );
  }
}