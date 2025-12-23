import 'dart:math';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


import 'dart:html' as html;

class CoffeeShopsPage extends StatefulWidget {
  const CoffeeShopsPage({super.key});

  @override
  State<CoffeeShopsPage> createState() => _CoffeeShopsPageState();
}

class _CoffeeShopsPageState extends State<CoffeeShopsPage> {
  final Random random = Random();

  final List<Map<String, String>> allPersons = [
    {"name": "Ahmed Chawki", "address": "Belvédère, Rue Azaytoun, Casablanca"},
    {"name": "Nabil Idrissi", "address": "Maarif, Rue Normandie, Casablanca"},
    {"name": "Youssef Amrani", "address": "Derb Omar, Casablanca"},
    {"name": "Kamal El Fassi", "address": "Ain Sebaâ, Rue 12, Casablanca"},
    {"name": "Redouane Tahiri", "address": "Sidi Maârouf, Technopark, Casablanca"},
    {"name": "Zakaria Berrada", "address": "Bourgogne, Rue Tantan, Casablanca"},
    {"name": "Saad Essafi", "address": "Oulfa, Lotissement Essalam, Casablanca"},
    {"name": "Youness Lahlou", "address": "Racine, Boulevard Zerktouni, Casablanca"},
    {"name": "Othmane Sebti", "address": "Hay Hassani, Rue Sakia, Casablanca"},
    {"name": "Ismail Moutaoukil", "address": "Gauthier, Rue Abou Kacem, Casablanca"},
  ];

  List<Map<String, String>> displayedPersons = [];

  @override
  void initState() {
    super.initState();
    loadRandomPersons();
  }

  void loadRandomPersons() {
    displayedPersons = [];
    List<int> used = [];

    while (displayedPersons.length < 4) {
      final i = random.nextInt(allPersons.length);
      if (!used.contains(i)) {
        used.add(i);
        displayedPersons.add(allPersons[i]);
      }
    }
  }

  // khchina google maps 
  Future<void> openAddress(String address) async {
    final String mapsUrl =
        "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}";

    try {
      // ouverture garantie
      html.window.open(mapsUrl, "_blank");
      return;
    } catch (e) {
      // MOBILE 
      final Uri uri = Uri.parse(mapsUrl);
      if (!await launchUrl(uri, mode: LaunchMode.platformDefault)) {
        throw Exception("Impossible d’ouvrir Google Maps");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("📍 Personnes proches"),
        backgroundColor: Colors.brown[800],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(
            "Personnes localisées près de toi :",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 20),

          for (var p in displayedPersons)
            Container(
              margin: const EdgeInsets.only(bottom: 15),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.brown.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  )
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.brown[200],
                        child: const Icon(Icons.person, color: Colors.brown),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        p["name"]!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    p["address"]!,
                    style: const TextStyle(color: Colors.black54),
                  ),
                  const SizedBox(height: 12),
                  ElevatedButton.icon(
                    onPressed: () => openAddress(p["address"]!),
                    icon: const Icon(Icons.location_on),
                    label: const Text("Voir la localisation"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.brown[700],
                      foregroundColor: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
