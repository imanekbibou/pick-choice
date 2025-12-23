import 'package:pick_choix/services/web3_bridge.dart';

class ContractService {
  static const String contractAddress =
      "0x7C88fCA3443Ad746c82B1A742abCd38865aA1391";

  /// ABI (exactement tes 2 fonctions)
  static const String abi = '''
[
  {
    "inputs": [
      { "internalType": "string", "name": "_itemName", "type": "string" },
      { "internalType": "string", "name": "_extraInfo", "type": "string" }
    ],
    "name": "saveCoffee",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  },
  {
    "inputs": [
      { "internalType": "string", "name": "_itemName", "type": "string" },
      { "internalType": "string", "name": "_extraInfo", "type": "string" }
    ],
    "name": "saveBakery",
    "outputs": [],
    "stateMutability": "nonpayable",
    "type": "function"
  }
]
''';

  static Future<void> saveCoffee(String name, String extra) async {
    await Web3Bridge.connect();
    await Web3Bridge.saveCoffee(contractAddress, abi, name, extra);
  }

  static Future<void> saveBakery(String name, String extra) async {
    await Web3Bridge.connect();
    await Web3Bridge.saveBakery(contractAddress, abi, name, extra);
  }
}
