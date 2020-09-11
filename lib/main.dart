import 'package:flutter/material.dart';
import 'package:gbp/pages/detallePage.dart';
import 'package:gbp/pages/homePage.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grupo Bien Pensado',
      initialRoute: 'Home', 
      routes: {
        'Home'        : ( BuildContext context ) => HomePage(),
        'DetailPage'  : ( BuildContext context ) => DetailPage(),
      },
    );
  }
}

