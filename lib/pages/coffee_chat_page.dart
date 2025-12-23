import 'package:flutter/material.dart';
import '../services/ai_service.dart';

//StatefulWidget car la page change : étapes, messages, boutons.

//coffeeName = café sélectionné depuis la page précédente.

//required : on doit obligatoirement fournir ce nom.
class CoffeeChatPage extends StatefulWidget {
  final String coffeeName;

  const CoffeeChatPage({super.key, required this.coffeeName});

  @override
  State<CoffeeChatPage> createState() => _CoffeeChatPageState();
}

class _CoffeeChatPageState extends State<CoffeeChatPage> {
  final AIService ai = AIService();
// step control button ecran
  String step = "welcome"; 
  String? drinkTime;
  String? illness;
  String iaMessage = "";

  // Définition de couleurs constantes
  static const Color primaryBrown = Color(0xFF5D4037);
  static const Color secondaryBrown = Color(0xFF795548);
  static const Color lightBrown = Color(0xFFD7CCC8);
  static const Color veryLightBrown = Color(0xFFEFEBE9);
  static const Color accentAmber = Color(0xFFFF8F00);
  static const Color lightAmber = Color(0xFFFFECB3);
  static const Color whiteColor = Colors.white;
  static const Color textColor = Color(0xFF3E2723);

  @override
  // il ce lance lorsque la page demarre 
  void initState() {
    super.initState();
    iaMessage = "☕ Bienvenue ! Vous avez choisi : ${widget.coffeeName}.";//acces  au parametre recu 
  }
  // calcul de caffeine 

  double computeCaffeine() {
    if (illness == null || illness == "aucune") {
      switch (drinkTime) {
        case "matin":
          return 80;
        case "après-midi":
          return 60;
        case "soir":
          return 30;
        default:
          return 50;
      }
    }

    switch (illness) {
      case "Diabète":
        return 20;
      case "Grossesse":
        return 5;
      case "Anxiété":
        return 15;
      case "Hypertension":
        return 10;
      default:
        return 40;
    }
  }

  void nextStep(String? value) {
    switch (step) {
      case "welcome":
        step = "drink_time";
        iaMessage = "🕐 À quel moment de la journée souhaitez-vous boire votre café ?";
        break;

      case "drink_time":
        drinkTime = value;
        if (value == "matin") {
          iaMessage = "🌅 Le matin, parfait pour un bon café ! Avez-vous une condition médicale particulière ?";
        } else if (value == "après-midi") {
          iaMessage = "🌤️ L'après-midi, idéal pour une pause café. Avez-vous une condition médicale particulière ?";
        } else {
          iaMessage = "🌙 Le soir, attention à la caféine. Avez-vous une condition médicale particulière ?";
        }
        step = "illness_question";
        break;

      case "illness_question":
        if (value == "non") {
          illness = "aucune";
          step = "result";
          computeResult();
        } else {
          iaMessage = "🤒 Laquelle de ces conditions médicales vous concerne ?";
          step = "illness_type";
        }
        break;

      case "illness_type":
        illness = value;
        step = "result";
        computeResult();
        break;
    }

    setState(() {});
  }

  void computeResult() {
    double caffeine = computeCaffeine();
    String advice = "";

    switch (illness) {
      case "aucune":
        advice = "Profitez de votre café en toute sérénité.";
        break;
      case "Diabète":
        advice = "Privilégiez un café faible en sucre, avec du lait végétal si possible.";
        break;
      case "Grossesse":
        advice = "Décaféiné recommandé, avec l'accord de votre médecin.";
        break;
      case "Anxiété":
        advice = "Évitez les cafés forts, préférez un léger arabica.";
        break;
      case "Hypertension":
        advice = "Bois un café très léger, sans excès de sel ni de sucre.";
        break;
    }

    iaMessage =
        " 📝Recommandation personnalisée\n\n"
        " 🥤Caféine conseillée : ${caffeine.toStringAsFixed(0)} mg\n"
        "☕Café sélectionné : ${widget.coffeeName}\n"
        " 🕐Moment : ${drinkTime ?? "Non spécifié"}\n\n"
        "💡 Conseil santé : $advice\n\n"
        "🍰 Accompagnement suggéré :Un pain au chocolat de chez PAUL";
  }
// had button il fait une appel dial sak samedi soir hhhh
  Widget replyButton(String text, String value, {IconData? icon}) {
    return Container(
      margin: const EdgeInsets.only(right: 12, bottom: 8),
      child: ElevatedButton(
        //on a créé un widget réutilisable pour éviter la répétition de code.
        onPressed: () => nextStep(value),
        style: ElevatedButton.styleFrom(
          backgroundColor: veryLightBrown,
          foregroundColor: textColor,
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: const BorderSide(color: lightBrown, width: 1),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) ...[
              Icon(icon, size: 18),
              const SizedBox(width: 8),
            ],
            Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _buildMessageBubble(String message) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.only(bottom: 25),
      decoration: BoxDecoration(
        color: veryLightBrown,
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color(0x1A000000),
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: const BoxDecoration(
                  color: lightBrown,
                  shape: BoxShape.circle,
                ),
                child: const Icon(Icons.coffee, color: primaryBrown, size: 20),
              ),
              const SizedBox(width: 12),
              const Text(
                "Coffee Assistant",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: primaryBrown,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Text(
            message,
            style: const TextStyle(
              fontSize: 16,
              height: 1.5,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  // 39li mzian katcreer la table a la base du scaffold il contient appbar+body  
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.coffee, color: whiteColor),
            SizedBox(width: 12),
            Text(   
              "Coffee Assistant",
              style: TextStyle(
                color: whiteColor,
                fontWeight: FontWeight.w600,
                fontSize: 20,
              ),
            ),
          ],
        ),
        backgroundColor: primaryBrown,
        elevation: 0,
        centerTitle: false,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFF9F5F0),
              Color(0xFFF0E6D6),
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header élégant
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 20),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x1A000000),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        backgroundColor: lightBrown,
                        child: Icon(Icons.local_cafe, color: primaryBrown),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Votre sélection",
                              style: TextStyle(
                                color: secondaryBrown,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              widget.coffeeName,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: textColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: veryLightBrown,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          "IA",
                          style: TextStyle(
                            color: primaryBrown,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // Message de l'IA
                _buildMessageBubble(iaMessage),

                // hna bch kayt2afficha message 
                if (step == "result") ...[
  const SizedBox(height: 30),

  // Container élégant pour les boutons
  Container(
    width: double.infinity,
    padding: const EdgeInsets.all(24),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(20),
      boxShadow: const [
        BoxShadow(
          color: Color(0x14000000),
          blurRadius: 15,
          spreadRadius: 2,
          offset: Offset(0, 4),
        ),
      ],
      border: Border.all(
        color: lightBrown,
        width: 1,
      ),
    ),
    child: Column(
      children: [
        // TITRE
        Padding(
          padding: const EdgeInsets.only(bottom: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: veryLightBrown,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.explore,
                  color: primaryBrown,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                "Explorer les options",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: textColor,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),

        // BOUTON COFFEE SHOP 
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/coffee_shops");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryBrown,
              foregroundColor: whiteColor,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              elevation: 4,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: secondaryBrown,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.location_on, size: 22, color: whiteColor),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Trouver un Coffee Shop",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: whiteColor,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Proche de votre position",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: lightBrown,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: whiteColor, size: 24),
              ],
            ),
          ),
        ),

        const Padding(
          padding: EdgeInsets.symmetric(vertical: 12),
          child: Divider(color: lightBrown, thickness: 1),
        ),

        // BOUTON BOULANGERIE 🥐
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Navigator.pushNamed(context, "/pick_boulangerie");
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: whiteColor,
              foregroundColor: textColor,
              padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 24),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
                side: const BorderSide(color: lightBrown, width: 1.5),
              ),
              elevation: 2,
            ),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: lightAmber,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(Icons.bakery_dining,
                      size: 22, color: accentAmber),
                ),
                const SizedBox(width: 16),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Boulangeries conseillées",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        "Pour accompagner votre café",
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: secondaryBrown,
                        ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right,
                    color: secondaryBrown, size: 24),
              ],
            ),
          ),
        ),
      ],
    ),
  ),

  const SizedBox(height: 20),
],

                // FIN BOUTONS FINAUX 

                // Boutons d'interaction IA
                if (step == "welcome")
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () => nextStep(null),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryBrown,
                        foregroundColor: whiteColor,
                        elevation: 4,
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      icon: const Icon(Icons.arrow_forward, size: 20),
                      label: const Text(
                        "Commencer la consultation",
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),

                if (step == "drink_time")
                  Wrap(
                    children: [
                      replyButton("Matin", "matin", icon: Icons.wb_sunny),
                      replyButton("Après-midi", "après-midi", icon: Icons.light_mode),
                      replyButton("Soir", "soir", icon: Icons.nightlight),
                    ],
                  ),

                if (step == "illness_question")
                  Wrap(
                    children: [
                      replyButton("Oui", "oui", icon: Icons.medical_services),
                      replyButton("Non", "non", icon: Icons.check_circle),
                    ],
                  ),

                if (step == "illness_type")
                  Wrap(
                    children: [
                      replyButton("Diabète", "Diabète", icon: Icons.monitor_heart),
                      replyButton("Grossesse", "Grossesse", icon: Icons.family_restroom),
                      replyButton("Anxiété", "Anxiété", icon: Icons.psychology),
                      replyButton("Hypertension", "Hypertension", icon: Icons.favorite),
                    ],
                  ),

                if (step != "result") ...[
                  const SizedBox(height: 30),
                  LinearProgressIndicator(
                    value: step == "welcome"
                        ? 0.1
                        : step == "drink_time"
                            ? 0.3
                            : step == "illness_question"
                                ? 0.6
                                : 0.8,
                    backgroundColor: lightBrown,
                    color: secondaryBrown,
                    minHeight: 4,
                    borderRadius: BorderRadius.circular(2),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    step == "welcome"
                        ? "Étape 1/4"
                        : step == "drink_time"
                            ? "Étape 2/4"
                            : step == "illness_question"
                                ? "Étape 3/4"
                                : "Étape 4/4",
                    style: const TextStyle(
                      color: secondaryBrown,
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}