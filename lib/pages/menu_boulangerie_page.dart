import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class BoulangerieMenuPage extends StatelessWidget {
  final String name;
  final String address;
  final String menuImage;
  final String phone;
  final String email;
  final String horaires;
  final List<Map<String, dynamic>> menuItems;

  const BoulangerieMenuPage({
    super.key,
    required this.name,
    required this.address,
    required this.menuImage,
    required this.phone,
    required this.email,
    required this.horaires,
    required this.menuItems,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ----------------------- HEADER AVEC IMAGE -----------------------
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: Colors.brown[800],
            flexibleSpace: FlexibleSpaceBar(
              centerTitle: true,
              titlePadding: const EdgeInsets.only(bottom: 14),
              title: Text(
                name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(blurRadius: 8, color: Colors.black),
                  ],
                ),
              ),
              background: GestureDetector(
                onTap: () => _showFullScreenImage(context),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      menuImage,
                      fit: BoxFit.cover,
                      color: Colors.black.withOpacity(0.35),
                      colorBlendMode: BlendMode.darken,
                    ),
                    const Positioned(
                      right: 20,
                      bottom: 20,
                      child: Icon(Icons.zoom_in, color: Colors.white, size: 32),
                    )
                  ],
                ),
              ),
            ),
          ),

          // ----------------------- CONTENU -----------------------
          SliverList(
            delegate: SliverChildListDelegate(
              [
                const SizedBox(height: 20),

                // ----------- MENU EN PREMIER -----------
                _buildMenuSection(),

                const SizedBox(height: 25),

                // ----------- CONTACT & INFO -----------
                _buildContactSection(),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // 🥐 MENU DÉTAILLÉ
  // ------------------------------------------------------------------
  Widget _buildMenuSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(18),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("🍞 Menu détaillé"),
          const SizedBox(height: 12),

          if (menuItems.isEmpty)
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 30),
              child: Center(
                child: Text(
                  "Menu en préparation...",
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),

          _buildMenuCategory("Pains", "pain"),
          _buildMenuCategory("Viennoiseries", "viennoiserie"),
          _buildMenuCategory("Pâtisseries", "patisserie"),
          _buildMenuCategory("Sandwichs & Salades", "sandwich"),
          _buildMenuCategory("Boissons", "boisson"),
        ],
      ),
    );
  }

  Widget _buildMenuCategory(String title, String key) {
    final items = menuItems
        .where((item) => (item["category"] ?? "").toLowerCase() == key)
        .toList();

    if (items.isEmpty) return const SizedBox();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 18),
        Text(title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown,
            )),
        const SizedBox(height: 10),

        Column(children: items.map((item) => _buildMenuItem(item)).toList()),
      ],
    );
  }

  Widget _buildMenuItem(Map<String, dynamic> item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.brown[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.brown[100]!),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // NOM + DESCRIPTION
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item["name"],
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.brown,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  item["description"] ?? "",
                  style: const TextStyle(fontSize: 14, color: Colors.black54),
                ),
              ],
            ),
          ),

          // PRIX
          Text(
            "${item["price"]} Dh",
            style: const TextStyle(
              fontSize: 16,
              color: Colors.orange,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // 📞 CONTACT & INFORMATIONS
  // ------------------------------------------------------------------
  Widget _buildContactSection() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(20),
      decoration: _boxDecoration(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionTitle("📞 Contact & Informations"),
          const SizedBox(height: 20),

          _contactRow(Icons.store, "Boulangerie", name),
          _contactRow(Icons.location_on, "Adresse", address),
          _contactRow(Icons.phone, "Téléphone", phone, clickable: true),
          _contactRow(Icons.email, "Email", email, clickable: true),
          _contactRow(Icons.access_time, "Horaires", horaires),

          const SizedBox(height: 25),

          ElevatedButton.icon(
            onPressed: () async {
              final url = Uri.parse(
                "https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(address)}",
              );
              await launchUrl(url, mode: LaunchMode.externalApplication);
            },
            icon: const Icon(Icons.location_on),
            label: const Text("Voir la localisation"),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown[800],
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contactRow(IconData icon, String label, String value,
      {bool clickable = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Row(
        children: [
          Icon(icon, color: Colors.brown[700], size: 22),
          const SizedBox(width: 12),
          Expanded(
            child: GestureDetector(
              onTap: clickable
                  ? () async {
                      final Uri link = Uri.parse(
                        icon == Icons.phone ? "tel:$value" : "mailto:$value",
                      );
                      await launchUrl(link);
                    }
                  : null,
              child: Text(
                "$label : $value",
                style: TextStyle(
                  fontSize: 15,
                  color: clickable ? Colors.blue : Colors.black87,
                  decoration:
                      clickable ? TextDecoration.underline : TextDecoration.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ------------------------------------------------------------------
  // 🔍 IMAGE FULL SCREEN
  // ------------------------------------------------------------------
  void _showFullScreenImage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          body: Center(
            child: InteractiveViewer(
              maxScale: 4,
              minScale: 0.5,
              child: Image.asset(menuImage),
            ),
          ),
        ),
      ),
    );
  }

  // ------------------------------------------------------------------
  // UTILITAIRES
  // ------------------------------------------------------------------
  BoxDecoration _boxDecoration() => BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.18),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      );

  Widget _sectionTitle(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Colors.brown,
      ),
    );
  }
}
