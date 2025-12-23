class CoffeeType {
  final String name;
  final String description;
  final int caffeineMg; // quantité de caféine moyenne

  CoffeeType({
    required this.name,
    required this.description,
    required this.caffeineMg,
  });
}

List<CoffeeType> coffeeList = [
  CoffeeType(
    name: "Espresso",
    description: "Un café fort et concentré.",
    caffeineMg: 80,
  ),
  CoffeeType(
    name: "Latte",
    description: "Café avec beaucoup de lait.",
    caffeineMg: 60,
  ),
  CoffeeType(
    name: "Cappuccino",
    description: "Mousseux avec du lait.",
    caffeineMg: 70,
  ),
  CoffeeType(
    name: "Americano",
    description: "Allongé avec de l'eau chaude.",
    caffeineMg: 95,
  ),
  CoffeeType(
    name: "Mocha",
    description: "Café chocolaté.",
    caffeineMg: 65,
  ),
  CoffeeType(
    name: "Macchiato",
    description: "Espresso avec un peu de lait.",
    caffeineMg: 85,
  ),
];
