import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin {

   bool isChatOpen = false;
   // hadi recuperer ach kyktb user 

   final TextEditingController _chatController = TextEditingController();

final List<String> messages = [
  "👋 Bienvenue sur PickChoice!\n"
  "Je suis votre assistant virtuel.\n\n"
  "📌 Voici les catégories que vous pouvez explorer :  \n"
  "🍵 1. PickCoffee\n"
  "   ➤ Tapez : coffee, café, boisson\n\n"
  "🥐 2. PickBoulangerie\n"
  "   ➤ Tapez : boulangerie, pain, croissant, pâtisserie\n\n"
  "📋 3. Menus & Produits\n"
  "   ➤ Tapez : menu, produits, catégorie, liste\n\n"
  "ℹ️ 4. Informations générales\n"
  "   ➤ Tapez : prix, horaires, infos, service\n\n"
  "💡 5. Fonctionnement de l'application\n"
  "   ➤ Tapez : comment ça marche, utilisation, aide\n\n"
  "❓ 6. Assistance & Questions\n"
  "   ➤ Tapez : aide, question, support\n\n"
  "👉 Écrivez un mot-clé pour commencer."
];


//  IA LOCALE  fih dkchi liktbna hnaa  avec les cond dial kol message
String askLocalAI(String message) {
  message = message.toLowerCase();

  // Salutations
  if (message.contains("bonjour") || message.contains("salut") || message.contains("hello")) {
    return "Bonjour 👋 ! Je suis votre assistant PickChoice. Posez-moi vos questions sur PickCoffee, PickBoulangerie ou l'application.";
  }

  // Présentation générale
  if (message.contains("Pickchoice") || message.contains("application")) {
    return "Pickchoice est une application qui vous permet d'explorer deux services : PickCoffee et PickBoulangerie. Vous pouvez consulter les menus, les produits et obtenir des informations détaillées.";
  }

  // PickCoffee
  if (message.contains("coffee") || message.contains("café") || message.contains("pickcoffee")) {
    return "PickCoffee ☕ vous propose : cafés chauds, boissons glacées, boissons aromatisées, chocolats, thés…\nSouhaitez-vous consulter les catégories ou un produit ?";
  }

  // PickBoulangerie
  if (message.contains("boulangerie") || message.contains("pain") || message.contains("viennoiserie") || message.contains("croissant") || message.contains("pâtisserie")) {
    return "PickBoulangerie 🥐 propose : croissants, pains au chocolat, desserts, tartes, baguettes, pains spéciaux.\nVoulez-vous une catégorie ou la description d’un produit ?";
  }

  // Menus
  if (message.contains("menu") || message.contains("produit") || message.contains("catégorie")) {
    return "Voici les menus de Pickchoice :\n\n"
        "☕ PickCoffee: cafés, chocolats, boissons froides, thés aromatisés, frappés.\n"
        "🥐 PickBoulangerie: croissants, pains, desserts, gâteaux, tartes.\n\n"
        "Souhaitez-vous un détail sur un produit ?";
  }

  // Fonctionnement
  if ((message.contains("comment") && message.contains("marche")) ||
      (message.contains("fonctionne"))) {
    return "Le fonctionnement est simple :\n"
        "1️⃣ Choisissez PickCoffee ou PickBoulangerie\n"
        "2️⃣ Explorez les menus\n"
        "3️⃣ Sélectionnez un produit pour voir les détails\n"
        "4️⃣ Naviguez facilement entre les sections\n\n"
        "Je peux vous guider si vous le souhaitez.";
  }

  // Informations générales
  if (message.contains("aide") || message.contains("question") || message.contains("support") || message.contains("besoin")) {
    return "Je peux vous aider concernant :\n"
        "- PickCoffee\n"
        "- PickBoulangerie\n"
        "- Menus & Produits\n"
        "- Fonctionnement de l'application\n"
        "- Informations (prix, horaires…)\n\n"
        "Posez-moi votre question 😊";
  }

  // Prix
  if (message.contains("prix") || message.contains("tarif")) {
    return "Les prix varient selon les produits. Vous pouvez consulter les tarifs dans les pages PickCoffee et PickBoulangerie.";
  }

  // Horaires
  if (message.contains("horaires") || message.contains("ouvert") || message.contains("fermé")) {
    return "Les horaires dépendent de votre établissement. Consultez la section Informations pour plus de détails.";
  }

  // Merci
  if (message.contains("merci")) {
    return "Avec plaisir ! 😊 N'hésitez pas à me demander si vous avez d'autres questions.";
  }

  // Réponse générique
  return "Je n’ai pas compris votre demande 🤔.\n"
      "Essayez un mot-clé comme : coffee, boulangerie, menu, prix, aide, comment ça marche…";
}

// sift whd  MESSAGE OBTENIR UNE RÉPONSE 
void sendMessage() {
  String text = _chatController.text.trim();
  if (text.isEmpty) return;

  setState(() {
    messages.add("Toi : $text");
  });

  _chatController.clear();

  String botReply = askLocalAI(text);

  setState(() {
    messages.add("ChatBot : $botReply");
  });
}




// scroler automatiquement 
  final ScrollController _scrollController = ScrollController();
  // HAD  GlobalKey pour naviguer dynamiquement dans la page.
  final aboutKey = GlobalKey();
  final serviceKey = GlobalKey();
  final contactKey = GlobalKey();
  final int _selectedNavIndex = 0;

//ANIMATION BAYNA DIAL LES ANNIMATION DIAL LA PAGE 
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<Offset> _slideAnimation;
// HAD FONCTION POUR Lance les animations dès l’ouverture.
  @override
  void initState() {
    super.initState();
    
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );
    //Effet de zoom élégant
    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.elasticOut,
      ),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );
    
    _animationController.forward();
  }
  // HADI Nettoyage mémoire

  @override
  void dispose() {
    _animationController.dispose();
    _scrollController.dispose();
    super.dispose();
  }
// scrole bin les navigation 1 seconds 
  void scrollTo(GlobalKey key) async {
    await Future.delayed(const Duration(milliseconds: 100));
    if (key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(seconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }

  void scrollToTop() {
    _scrollController.animateTo(
      0,
      duration: const Duration(seconds: 1),
      curve: Curves.easeInOut,
    );
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    extendBodyBehindAppBar: true,
    appBar: AppBar(
      backgroundColor: Colors.black.withOpacity(0.4),
      elevation: 0,
      title: Row(
        children: [
          const Text(
            "Pickchoice",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 24,
              letterSpacing: 2,
            ),
          ),
          const Spacer(),
          _navItem("Home", () => scrollToTop()),
          const SizedBox(width: 25),
          _navItem("About", () => scrollTo(aboutKey)),
          const SizedBox(width: 25),
          _navItem("Service", () => scrollTo(serviceKey)),
          const SizedBox(width: 25),
          _navItem("Contact", () => scrollTo(contactKey)),
        ],
      ),
    ),

    // hadi bina bch REMPLACE LE BODY COMPLET POUR AJOUTER LE CHATBOT
    body: Stack(
      children: [
        // ⚡ TON CONTENU ORIGINAL
        SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              _headerSection(),
              _aboutSection(),
              _serviceSection(),
              _contactSection(),
            ],
          ),
        ),

        //  FENÊTRE DU CHATBOT (s'affiche seulement quand isChatOpen == true)
        if (isChatOpen)
          Positioned(
            bottom: 90,
            right: 20,
            child: _chatWindow(),
          ),

        //  BOUTON FLOTTANT POUR OUVRIR / FERMER LE CHATBOT
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            backgroundColor: Colors.orange,
            onPressed: () {
              setState(() {
                isChatOpen = !isChatOpen;
              });
            },
            child: Icon(
              isChatOpen ? Icons.close : Icons.chat_bubble_rounded,
              color: Colors.white,
            ),
          ),
        ),
      ],
    ),
  );
}


  //  HEADER SECTION - Design chic mélange café & boulangerie avec carousel automatique
  Widget _headerSection() {
    return SizedBox(
      height: 900,
      width: double.infinity,
      child: Stack(
        children: [
          // Background avec carousel automatique d'images
          Positioned.fill(
            child: _AutoImageCarousel(),
          ),

          // Éléments décoratifs animés
          Positioned(
            top: 100,
            left: 50,
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFF8B4513).withOpacity(0.3), // Brun café
                      width: 2,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            bottom: 100,
            right: 80,
            child: SlideTransition(
              position: _slideAnimation,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFD4A762).withOpacity(0.4), // Or boulangerie
                      width: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Motif grains de café animés
          Positioned(
            top: 200,
            right: 100,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Icon(
                Icons.coffee_rounded,
                color: const Color(0xFF8B4513).withOpacity(0.2),
                size: 40,
              ),
            ),
          ),

          Positioned(
            bottom: 200,
            left: 100,
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Icon(
                Icons.bakery_dining_rounded,
                color: const Color(0xFFD4A762).withOpacity(0.2),
                size: 40,
              ),
            ),
          ),

          // Contenu principal
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Titre principal avec animation
                  SlideTransition(
                    position: _slideAnimation,
                    child: FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          Text(
                            "Pickchoice ",
                            style: TextStyle(
                              fontSize: 72,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 3,
                              shadows: [
                                Shadow(
                                  blurRadius: 20,
                                  color: Colors.black.withOpacity(0.5),
                                  offset: const Offset(3, 3),
                                ),
                              ],
                              fontFamily: 'PlayfairDisplay',
                            ),
                          ),
                          const SizedBox(height: 15),
                          
                          Text(
                            "L’art du Café et de la Boulangerie Artisanale",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w300,
                              color: Colors.orange.shade100,
                              letterSpacing: 4,
                              fontFamily: 'PlayfairDisplay',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                  
                  //  hadi bch kt9sem kola whda 
                  //Séparateur élégant avec dégradé café/boulangerie
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Container(
                      height: 3,
                      width: 200,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF8B4513), // Brun café
                            Color(0xFFD4A762), // Or boulangerie
                            Color(0xFF8B4513), // Brun café
                          ],
                        ),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 40),
                  
                  // Description dial dik ktbba 
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: const Text(
                      "Plongez dans une expérience gourmande mêlant cafés d’exception et créations boulangères préparées avec savoir-faire.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white70,
                        height: 1.6,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 60),

                  //  hadi Boutons de sélection avec design fusion
                FadeTransition(
  opacity: _fadeAnimation,
  child: SlideTransition(
    position: _slideAnimation,
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // hadi Bouton PICK COFFEE avec effet de clic avancé 
        StatefulBuilder(
          builder: (context, setState) {
            bool isTapped1 = false;
            return GestureDetector(
              onTapDown: (_) => setState(() => isTapped1 = true),
              onTapUp: (_) => setState(() => isTapped1 = false),
              onTapCancel: () => setState(() => isTapped1 = false),
              onTap: () => Navigator.pushNamed(context, "/pick_coffee"),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                transform: Matrix4.identity()..scale(isTapped1 ? 0.92 : 1.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isTapped1 
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                            spreadRadius: 2,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 25,
                            offset: const Offset(0, 15),
                            spreadRadius: 2,
                          ),
                        ],
                  ),
                  child: _fusionSelectionCard(
                    image: "https://images.unsplash.com/photo-1509042239860-f550ce710b93?w=500",
                    title: "Pick Coffee",
                    subtitle: "Cafés sélectionnés pour une expérience unique",
                    icon: Icons.coffee_rounded,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF4C2A85).withOpacity(0.9),
                        const Color(0xFF8B4513).withOpacity(0.8),
                      ],
                    ),
                    onTap: () => Navigator.pushNamed(context, "/pick_coffee"),
                  ),
                ),
              ),
            );
          },
        ),
        
        const SizedBox(width: 30),
        
        //  hada Bouton PICK BOULANGERIE avec effet de clic avancé
        StatefulBuilder(
          builder: (context, setState) {
            bool isTapped2 = false;
            return GestureDetector(
              onTapDown: (_) => setState(() => isTapped2 = true),
              onTapUp: (_) => setState(() => isTapped2 = false),
              onTapCancel: () => setState(() => isTapped2 = false),
              onTap: () => Navigator.pushNamed(context, "/pick_boulangerie"),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 100),
                transform: Matrix4.identity()..scale(isTapped2 ? 0.92 : 1.0),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 100),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: isTapped2 
                      ? [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                            spreadRadius: 2,
                          ),
                        ]
                      : [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.4),
                            blurRadius: 25,
                            offset: const Offset(0, 15),
                            spreadRadius: 2,
                          ),
                        ],
                  ),
                  child: _fusionSelectionCard(
                    image: "https://images.unsplash.com/photo-1509365465985-25d11c17e812?w=1000",
                    title: "Pick Boulangerie",
                    subtitle: "Boulangerie artisanale et douceurs faites maison",
                    icon: Icons.bakery_dining_rounded,
                    gradient: LinearGradient(
                      colors: [
                        const Color(0xFF8B4513).withOpacity(0.9),
                        const Color(0xFFD4A762).withOpacity(0.8),
                      ],
                    ),
                    onTap: () => Navigator.pushNamed(context, "/pick_boulangerie"),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    ),
  ),
),
                  const SizedBox(height: 40),

                  // Indicateur scrolli  animé 
                  FadeTransition(
                    opacity: _fadeAnimation,
                    child: Column(
                      children: [
                        Text(
                          "EXPLOREZ NOTRE UNIVERS",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.6),
                            letterSpacing: 2,
                          ),
                        ),
                        const SizedBox(height: 10),
                        AnimatedContainer(
                          duration: const Duration(seconds: 2),
                          curve: Curves.easeInOut,
                          child: Icon(
                            Icons.expand_more_rounded,
                            color: Colors.white.withOpacity(0.6),
                            size: 24,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  //  COMPOSANT CAROUSEL AUTOMATIQUE
  Widget _AutoImageCarousel() {
    return StatefulBuilder(
      builder: (context, setState) {
        return Stack(
          children: [
            // Image principale avec fondu
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 1500),
              child: Container(
                key: ValueKey(_currentImageIndex),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(_carouselImages[_currentImageIndex]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            
            // Overlay pour meilleure lisibilité
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.black.withOpacity(0.3),
                    Colors.black.withOpacity(0.5),
                    Colors.black.withOpacity(0.7),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Variables pour le carousel les image page decrant 
  final int _currentImageIndex = 0;
  final List<String> _carouselImages = [
    "https://images.unsplash.com/photo-1495474472287-4d71bcdd2085?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80",
    "https://images.unsplash.com/photo-1509440159596-0249088772ff?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1772&q=80",
    "https://images.unsplash.com/photo-1554118811-1e0d58224f24?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1770&q=80",
    "https://images.unsplash.com/photo-1568254183919-78a4f43a2877?ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D&auto=format&fit=crop&w=1769&q=80",
  ];

  //   hadi il permet de naviguer vers PickCoffee ou PickBoulangerie avec une expérience visuelle avancée.
  Widget _fusionSelectionCard({
    required String image,
    required String title,
    required String subtitle,
    required IconData icon,
    required Gradient gradient,
    // had on tap  hya whd action du clic 
    required VoidCallback onTap,
  }) {
    // il  indisue lelement  cliquable
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        // kadir anumation naturelle 
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          width: 280,
          height: 350,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                blurRadius: 25,
                offset: const Offset(0, 15),
                spreadRadius: 2,
              ),
            ],
          ),
          child: Stack(
            children: [
              // Image de fond
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.network(
                  image,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              
              // Overlay avec dégradé
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                      Colors.black.withOpacity(0.2),
                    ],
                  ),
                ),
              ),
              
              // Effet de bordure animée au survol
              MouseRegion(
                onEnter: (_) => setState(() {}),
                onExit: (_) => setState(() {}),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                ),
              ),
              
              // Icône en haut à droite
              Positioned(
                top: 20,
                right: 20,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    icon,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
              
              // Contenu
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                        letterSpacing: 1.5,
                        fontFamily: 'PlayfairDisplay',
                      ),
                    ),
                    
                    const SizedBox(height: 8),
                    
                    Text(
                      subtitle,
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFFD4A762),
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    
                    const SizedBox(height: 15),
                    
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      height: 2,
                      width: 60,
                      decoration: BoxDecoration(
                        gradient: gradient,
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // Indicateur de clic
                    Row(
                      children: [
                        Text(
                          "Découvrir",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.white.withOpacity(0.7),
                            letterSpacing: 1.1,
                          ),
                        ),
                        const SizedBox(width: 5),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white.withOpacity(0.7),
                          size: 12,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ABOUT SECTION avec animation au scroll
  Widget _aboutSection() {
    return Container(
      key: aboutKey,
      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 100),
      color: const Color(0xFF1a1a1a),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 1,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "À propos de nous",
                  style: TextStyle(
                    fontSize: 42,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                    letterSpacing: 2,
                  ),
                ),
                
                Container(
                  height: 3,
                  width: 80,
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  color: const Color(0xFFD4A762),
                ),
                
                const SizedBox(height: 30),
                
                _aboutItem(
                  title: "Notre Histoire",
                  description: "Pickchoice est né d’une passion sincère pour le goût et l’authenticité Nous allions savoir-faire artisanal et innovation pour vous offrir des expériences café et boulangerie exceptionnelles",
                ),
                
                const SizedBox(height: 40),
                
                _aboutItem(
                  title: "Notre Vision",
                  description: "Pickchoice ambitionne de moderniser votre expérience d’achat en vous guidant vers des produits qui correspondent parfaitement à vos goûts.",
                ),
                
                const SizedBox(height: 40),
                
                _animatedButton(
                  text: "En savoir plus",
                  onTap: () {},
                ),
              ],
            ),
          ),
          
          const SizedBox(width: 80),
          
          Expanded(
            flex: 1,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Image.network(
                "https://images.unsplash.com/photo-1511920170033-f8396924c348?w=800",
                height: 500,
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // SERVICE SECTION
  Widget _serviceSection() {
    return Container(
      key: serviceKey,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 60),
      color: const Color(0xFF2a2a2a),
      child: Column(
        children: [
          const Text(
            "NOS SERVICES",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          
          Container(
            height: 3,
            width: 80,
            margin: const EdgeInsets.symmetric(vertical: 20),
            color: const Color(0xFFD4A762),
          ),
          
          const SizedBox(height: 10),
          
          const Text(
            "PRODUIT DE SERVICE",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white70,
              letterSpacing: 1.5,
            ),
          ),
          
          const SizedBox(height: 50),
          
          Row(
            children: [
              Expanded(
                child: _animatedServiceCard(
                  icon: Icons.coffee_rounded,
                  title: "Grains Frais & Biologiques",
                  description: "Des grains de café frais et biologiques sélectionnés avec soin pour une expérience unique.",
                  color: const Color(0xFF8B4513),
                ),
              ),
              
              const SizedBox(width: 30),
              
              Expanded(
                child: _animatedServiceCard(
                  icon: Icons.emoji_food_beverage_rounded,
                  title: "Café de Qualité Supérieure",
                  description: "Une qualité exceptionnelle pour les amateurs de café exigeants.",
                  color: const Color(0xFFD4A762),
                ),
              ),
              
              const SizedBox(width: 30),
              
              Expanded(
                child: _animatedServiceCard(
                  icon: Icons.bakery_dining_rounded,
                  title: "Grains de Café Frais",
                  description: "Des grains torréfiés quotidiennement pour une fraîcheur optimale.",
                  color: const Color(0xFF4C2A85),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 40),
          
          Row(
            children: [
              Expanded(
                child: _animatedServiceCard(
                  icon: Icons.local_shipping_rounded,
                  title: "Service de Livraison",
                  description: "Livraison rapide et soignée de vos produits préférés.",
                  color: const Color(0xFF2E8B57),
                ),
              ),
              
              const SizedBox(width: 30),
              
              Expanded(
                child: _animatedServiceCard(
                  icon: Icons.celebration_rounded,
                  title: "Pâtisseries Artisanales",
                  description: "Pâtisseries et viennoiseries artisanales préparées quotidiennement.",
                  color: const Color(0xFFCD853F),
                ),
              ),
              
              const SizedBox(width: 30),
              
              Expanded(
                child: _animatedServiceCard(
                  icon: Icons.thumb_up_rounded,
                  title: "Premium Selection",
                  description: "Une curation exclusive des meilleurs produits café et boulangerie.",
                  color: const Color(0xFFDA70D6),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //  CONTACT SECTION
  Widget _contactSection() {
    return Container(
      key: contactKey,
      padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 60),
      color: const Color(0xFF1a1a1a),
      child: Column(
        children: [
          const Text(
            "CONTACTEZ-NOUS",
            style: TextStyle(
              fontSize: 42,
              fontWeight: FontWeight.w300,
              color: Colors.white,
              letterSpacing: 2,
            ),
          ),
          
          Container(
            height: 3,
            width: 80,
            margin: const EdgeInsets.symmetric(vertical: 20),
            color: const Color(0xFFD4A762),
          ),
          
          const SizedBox(height: 50),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _contactInfo(
                Icons.email_rounded,
                "EMAIL",
                "imaneyasmin@gmail.com",
              ),
              _contactInfo(
                Icons.phone_rounded,
                "PHONE",
                "+212 688 340 325",
              ),
              _contactInfo(
                Icons.location_on_rounded,
                "ADDRESS",
                "Casablanca, Morocco",
              ),
            ],
          ),
          
          const SizedBox(height: 50),
          
          Container(
            width: 400,
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.3),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFD4A762).withOpacity(0.3)),
            ),
            child: Column(
              children: [
                const TextField(
                  decoration: InputDecoration(
                    labelText: "Votre nom",
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD4A762)),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                
                const SizedBox(height: 20),
                
                const TextField(
                  decoration: InputDecoration(
                    labelText: "Votre Email",
                    labelStyle: TextStyle(color: Colors.white70),
                    border: OutlineInputBorder(),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFD4A762)),
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
                
                const SizedBox(height: 30),
                
                _animatedButton(
                  text: "ENVOYER UN MESSAGE",
                  onTap: () {},
                  isPrimary: true,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  //  COMPOSANTS ANIMÉS

  Widget _animatedMainButton({
    required String text,
    required VoidCallback onTap,
    required bool isPrimary,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 400),
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          decoration: BoxDecoration(
            color: isPrimary ? const Color(0xFFD4A762) : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
            border: Border.all(
              color: isPrimary ? const Color(0xFFD4A762) : Colors.white,
              width: 1.5,
            ),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: const Color(0xFFD4A762).withOpacity(0.4),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                      spreadRadius: 2,
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.2),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isPrimary ? Colors.black : Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.w400,
              letterSpacing: 3,
              fontFamily: 'Georgia',
            ),
          ),
        ),
      ),
    );
  }

  Widget _animatedServiceCard({
    required IconData icon,
    required String title,
    required String description,
    required Color color,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: GestureDetector(
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: color.withOpacity(0.3)),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.2),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                padding: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 40,
                  color: color,
                ),
              ),
              
              const SizedBox(height: 20),
              
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: color,
                  letterSpacing: 1.2,
                ),
              ),
              
              const SizedBox(height: 15),
              
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white70,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _animatedButton({
    required String text,
    required VoidCallback onTap,
    bool isPrimary = false,
  }) {
    return MouseRegion(
      onEnter: (_) => setState(() {}),
      onExit: (_) => setState(() {}),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
          decoration: BoxDecoration(
            color: isPrimary ? const Color(0xFFD4A762) : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color(0xFFD4A762),
              width: 2,
            ),
            boxShadow: isPrimary
                ? [
                    BoxShadow(
                      color: const Color(0xFFD4A762).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : [],
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isPrimary ? Colors.white : const Color(0xFFD4A762),
              fontSize: 16,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  Widget _aboutItem({required String title, required String description}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: Color(0xFFD4A762),
            letterSpacing: 1.2,
          ),
        ),
        
        const SizedBox(height: 10),
        
        Container(
          height: 2,
          width: 40,
          color: const Color(0xFFD4A762).withOpacity(0.5),
        ),
        
        const SizedBox(height: 15),
        
        Text(
          description,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
            height: 1.6,
            letterSpacing: 1.1,
          ),
        ),
      ],
    );
  }

  Widget _contactInfo(IconData icon, String title, String info) {
    return Column(
      children: [
        Icon(
          icon,
          size: 40,
          color: const Color(0xFFD4A762),
        ),
        
        const SizedBox(height: 15),
        
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.white70,
            letterSpacing: 1.5,
          ),
        ),
        
        const SizedBox(height: 8),
        
        Text(
          info,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Widget _navItem(String text, VoidCallback onTap) {
  bool isHovered = false;
  
  return StatefulBuilder(
    builder: (context, setState) {
      return MouseRegion(
        onEnter: (_) => setState(() => isHovered = true),
        onExit: (_) => setState(() => isHovered = false),
        child: GestureDetector(
          onTap: onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: TextStyle(
                  fontSize: 16,
                  color: isHovered ? const Color(0xFFD4A762) : Colors.white,
                  letterSpacing: isHovered ? 2.0 : 1.2,
                  fontWeight: isHovered ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
              const SizedBox(height: 6),
              AnimatedContainer(
                duration: const Duration(milliseconds: 400),
                curve: Curves.fastOutSlowIn,
                width: isHovered ? 30 : 0,
                height: 2,
                decoration: BoxDecoration(
                  color: const Color(0xFFD4A762),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}

  // FENÊTRE DU CHATBOT 
  Widget _chatWindow() {
    return Container(
      width: 320,
      height: 420,
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.85),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.orangeAccent, width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            blurRadius: 15,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: Column(
        children: [
          const Text(
            "🤖 ChatBot Pickchoice",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),

          const Divider(color: Colors.orangeAccent),

          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: Text(
                    messages[index],
                    style: const TextStyle(color: Colors.white70),
                  ),
                );
              },
            ),
          ),

          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _chatController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    hintText: "Écrire...",
                    hintStyle: const TextStyle(color: Colors.white54),
                    filled: true,
                    fillColor: Colors.white10,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.orangeAccent),
                onPressed: sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }


}