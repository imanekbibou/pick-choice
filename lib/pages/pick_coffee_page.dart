import 'package:flutter/material.dart';
import '../data/coffee_list.dart';
import '../services/contract_service.dart';
import 'coffee_chat_page.dart';

class PickCoffeePage extends StatelessWidget {
  const PickCoffeePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAF5F0),
      body: Column(
        children: [
          // Header élégant
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + 20,
              bottom: 30,
            ),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF2C1810),
                  Color(0xFF4A2C1A),
                ],
              ),
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.brown.withOpacity(0.3),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              children: [
                const Text(
                  "SÉLECTION PRESTIGE",
                  style: TextStyle(
                    color: Color(0xFFE8D0B3),
                    fontSize: 14,
                    fontWeight: FontWeight.w300,
                    letterSpacing: 6.0,
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  "Nos Grands Crus",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'Playfair',
                  ),
                ),
                const SizedBox(height: 8),
                Container(
                  width: 60,
                  height: 2,
                  color: const Color(0xFFD4B896),
                ),
              ],
            ),
          ),

          // Liste des cafés
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 24),
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                itemCount: coffeeList.length,
                itemBuilder: (context, index) {
                  final coffee = coffeeList[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 16),
                    height: 120,
                    child: Stack(
                      children: [
                        // Carte principale
                        Positioned.fill(
                          child: Container(
                            margin: const EdgeInsets.only(left: 20, top: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.brown.withOpacity(0.1),
                                  blurRadius: 15,
                                  offset: const Offset(0, 5),
                                ),
                              ],
                              border: Border.all(
                                color: Colors.white,
                                width: 1,
                              ),
                            ),
                          ),
                        ),

                        // Accent coloré
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Container(
                            width: 6,
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Color(0xFFD4B896),
                                  Color(0xFF8B6B4C),
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(10),
                                bottomLeft: Radius.circular(10),
                              ),
                            ),
                          ),
                        ),

                        // Contenu
                        Positioned.fill(
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(20),
                           onTap: () async {
  try {
    // 1) Optionnel: afficher un chargement
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const Center(child: CircularProgressIndicator()),
    );

    // 2) Envoyer la transaction
    await ContractService.saveCoffee(coffee.name, "");

    // 3) Fermer le chargement
    if (context.mounted) Navigator.pop(context);

    // 4) Naviguer vers la page IA / chat
    if (!context.mounted) return;
   Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => CoffeeChatPage(
      coffeeName: coffee.name,
    ),
  ),
);

  } catch (e) {
    // Si erreur : fermer le chargement si ouvert
    if (context.mounted) Navigator.pop(context);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("❌ Erreur blockchain: $e")),
    );
  }
},


                              child: Padding(
                                padding: const EdgeInsets.all(20),
                                child: Row(
                                  children: [
                                    // Badge numéroté
                                    Container(
                                      width: 40,
                                      height: 40,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xFF2C1810),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.brown.withOpacity(0.3),
                                            blurRadius: 8,
                                            offset: const Offset(0, 3),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          "${index + 1}",
                                          style: const TextStyle(
                                            color: Color(0xFFE8D0B3),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ),

                                    const SizedBox(width: 20),

                                    // Informations café
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            coffee.name,
                                            style: const TextStyle(
                                              color: Color(0xFF2C1810),
                                              fontSize: 18,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: 0.5,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            coffee.description,
                                            style: const TextStyle(
                                              color: Color(0xFF7A6651),
                                              fontSize: 12,
                                              fontWeight: FontWeight.w400,
                                              height: 1.4,
                                            ),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ],
                                      ),
                                    ),

                                    // Icône flèche
                                    Container(
                                      width: 32,
                                      height: 32,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: const Color(0xFFFAF5F0),
                                        border: Border.all(
                                          color: const Color(0xFFE8D0B3),
                                          width: 1,
                                        ),
                                      ),
                                      child: const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        color: Color(0xFF8B6B4C),
                                        size: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),

          // Footer élégant
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                top: BorderSide(
                  color: Color(0xFFF0E6D6),
                  width: 1,
                ),
              ),
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.verified_rounded,
                  color: Color(0xFF8B6B4C),
                  size: 16,
                ),
                SizedBox(width: 8),
                Text(
                  "Blockchain Sécurisée",
                  style: TextStyle(
                    color: Color(0xFF7A6651),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    letterSpacing: 1.2,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showElegantSnackbar(BuildContext context, String coffeeName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xFF8B6B4C),
              ),
              child: const Icon(
                Icons.check,
                color: Colors.white,
                size: 16,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Enregistrement réussi",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "$coffeeName ajouté à la blockchain",
                    style: const TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        backgroundColor: const Color(0xFF2C1810),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        margin: const EdgeInsets.all(20),
        duration: const Duration(seconds: 3),
      ),
    );
  }
}