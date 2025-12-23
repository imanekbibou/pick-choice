import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/coffee_shops_page.dart';
import 'pages/pick_coffee_page.dart';
import 'pages/pick_boulangerie_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
// il décrit linterface principale de lapplication
  @override
  Widget build(BuildContext context) {
    // had material howa l9lb dial app fih kolchi 
    return MaterialApp(
      title: 'Pick Choix',
      // howa laikY7yed lina les bonde dial bug pour que laffichage il doit etre profesionnelle
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => const HomePage(),
        "/pick_coffee": (context) => const PickCoffeePage(),
        "/pick_boulangerie": (context) => PickBoulangeriePage(),
        "/coffee_shops": (context) => const CoffeeShopsPage(),
      },
    );
  }
}
