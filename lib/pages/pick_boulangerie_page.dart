import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:pick_choix/pages/menu_boulangerie_page.dart';
import '../services/contract_service.dart';


class PickBoulangeriePage extends StatelessWidget {
  PickBoulangeriePage({super.key});

  // 🔥 LES 8 BOULANGERIES CASABLANCA
  final List<Map<String, dynamic>> bakeries = [
    {
      "name": "PAUL Maroc",
      "address": "Maarif, 82 Bd Anfa, Casablanca",
      "menu": "assets/menus/paul_menu.jpg",
      "phone": "+212522987654",
      "email": "contact@paul.ma",
      "horaires": "Lun-Dim : 7h - 21h",
      "menuItems": [
        {
          "name": "Croissant",
          "price": 10,
          "category": "viennoiserie",
          "description": "Croissant pur beurre."
        },
        {
          "name": "Pain Complet",
          "price": 6,
          "category": "pain",
          "description": "Pain complet artisanal."
        },
      ]
    },
    {
      "name": "AMOUD",
      "address": "Gauthier, Casablanca",
      "menu": "assets/menus/amoud_menu.jpg",
      "phone": "+212522334455",
      "email": "contact@amoud.ma",
      "horaires": "Lun-Dim : 7h - 22h",
      "menuItems": [
        {
          "name": "Palmier",
          "price": 12,
          "category": "viennoiserie",
          "description": "Feuilletage croustillant au sucre."
        },
        {
          "name": "Tarte aux Fruits",
          "price": 35,
          "category": "patisserie",
          "description": "Tarte crème vanille & fruits."
        },
      ]
    },
    {
      "name": "La Maison du Pain",
      "address": "Palmier, Casablanca",
      "menu": "assets/menus/maison_pain_menu.jpg",
      "phone": "+212522445566",
      "email": "contact@maisondupain.ma",
      "horaires": "Lun-Sam : 7h - 20h",
      "menuItems": [
        {
          "name": "Pain aux Céréales",
          "price": 8,
          "category": "pain",
          "description": "Pain riche en fibres."
        },
      ]
    },
    {
      "name": "La Gourmandise (Ain Diab)",
      "address": "Ain Diab, Casablanca",
      "menu": "assets/menus/gourmandise_menu.jpg",
      "phone": "+212522556677",
      "email": "contact@gourmandise.ma",
      "horaires": "Lun-Dim : 8h - 23h",
      "menuItems": [
        {
          "name": "Éclair au Chocolat",
          "price": 20,
          "category": "patisserie",
          "description": "Pâtisserie au chocolat pur."
        },
      ]
    },
    {
      "name": "Les Maîtres du Pain",
      "address": "Gauthier, Casablanca",
      "menu": "assets/menus/maitres_pain_menu.jpg",
      "phone": "+212522667788",
      "email": "contact@maitresdupain.ma",
      "horaires": "Lun-Sam : 6h30 - 20h",
      "menuItems": [
        {
          "name": "Pain de campagne",
          "price": 7,
          "category": "pain",
          "description": "Pain rustique."
        }
      ]
    },
    {
      "name": "Pâtisserie Benjamin",
      "address": "Maarif, Casablanca",
      "menu": "assets/menus/benjamin_menu.jpg",
      "phone": "+212522778899",
      "email": "info@benjamin.ma",
      "horaires": "Lun-Dim : 8h - 19h",
      "menuItems": [
        {
          "name": "Mille-feuille",
          "price": 22,
          "category": "patisserie",
          "description": "Crème vanille & feuilletage."
        }
      ]
    },
    {
      "name": "La Sqala Bakery",
      "address": "Boulevard des Almohades, Casablanca",
      "menu": "assets/menus/sqala_menu.jpg",
      "phone": "+212522889900",
      "email": "contact@lasqala.ma",
      "horaires": "Lun-Dim : 7h - 19h",
      "menuItems": [
        {
          "name": "Baghrir",
          "price": 12,
          "category": "viennoiserie",
          "description": "Crêpe marocaine traditionnelle."
        }
      ]
    },
    {
      "name": "Pâtisserie Al Baraka",
      "address": "Roches Noires, Casablanca",
      "menu": "assets/menus/baraka_menu.jpg",
      "phone": "+212522998877",
      "email": "contact@albaraka.ma",
      "horaires": "Lun-Dim : 7h30 - 20h",
      "menuItems": [
        {
          "name": "Cornes de Gazelle",
          "price": 15,
          "category": "patisserie",
          "description": "Gâteau marocain aux amandes."
        }
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("🥐 Boulangeries à Casablanca"),
        backgroundColor: Colors.brown[800],
      ),
      body: ListView.builder(
        itemCount: bakeries.length,
        itemBuilder: (context, index) {
          final b = bakeries[index];

          return Container(
            margin: const EdgeInsets.all(12),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.15),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.brown[200],
                      child: const Icon(Icons.bakery_dining,
                          size: 30, color: Colors.brown),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      b["name"],
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(b["address"], style: const TextStyle(color: Colors.black54)),
                const SizedBox(height: 12),

                Row(
                  children: [
                    // 🍞 Voir Menu
                    ElevatedButton.icon(
                      onPressed: () async {
  final bakeryName = b["name"];

  try {
    // ✅ Envoi sur la blockchain (saveBakery)
 await ContractService.saveBakery(bakeryName, "");




    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("$bakeryName enregistré sur la blockchain"),
        backgroundColor: Colors.brown[700],
      ),
    );

    // Navigation vers la page Menu
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BoulangerieMenuPage(
          name: b["name"],
          address: b["address"],
          menuImage: b["menu"],
          email: b["email"],
          phone: b["phone"],
          horaires: b["horaires"],
          menuItems: b["menuItems"],
        ),
      ),
    );
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Erreur Blockchain : $e"),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
},

                      icon: const Icon(Icons.menu_book),
                      label: const Text("Voir le menu"),
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.brown[700],
                          foregroundColor: Colors.white),
                    ),

                    const SizedBox(width: 12),

                    // 📍 Localisation
                    ElevatedButton.icon(
                      onPressed: () async {
                        final url = Uri.parse(
                            "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(b["address"])}");
                        await launchUrl(url,
                            mode: LaunchMode.externalApplication);
                      },
                      icon: const Icon(Icons.location_pin),
                      label: const Text("Localisation"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green[700],
                        foregroundColor: Colors.white,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
