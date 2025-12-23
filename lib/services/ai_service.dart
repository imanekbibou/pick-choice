import 'dart:js' as js;
// had fichier derna fih  Chargement du modèle IA (model.json + .bin) 
class AIService {
  // fch kn3yto 3la had func pour prendre ca comme parametre 
  Future<List<double>> predict({
    required double age,
    required double gender,
    required double caffeine,
  }) async {
    // exeption   
    try {
      // mohima: appelle une fonction JS qui s’appelle predictCoffee.
      // hadi katakhd dkchi paramettre comme une list
     
      final jsResult = js.context.callMethod('predictCoffee', [
         //J’envoie les données sous forme de matrice 2D comme exigé par TensorFlow.js.
        [age, gender, caffeine]
      ]);
    // kanhwlo les donner dentre sous forme d'une list 
      return (jsResult as List)
          .map((e) => (e as num).toDouble())
          .toList();
    } catch (e) {
      return [0.0];
    }
  }
}


//AIService est un pont entre Flutter Web et JavaScript. Il envoie les données utilisateur à une fonction JS predictCoffee (TensorFlow.js) puis récupère le résultat et le convertit en List<double>. J’ai ajouté un try/catch pour gérer les erreurs et éviter le crash.