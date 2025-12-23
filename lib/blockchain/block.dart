import 'dart:convert';
import 'package:crypto/crypto.dart';

class Block {
  final int index;
  final String data;
  final String previousHash;
  final String hash;
  final DateTime timestamp;

  Block({
    required this.index,
    required this.data,
    required this.previousHash,
    required this.hash,
    required this.timestamp,
  });

  static String calculateHash(
      int index, String data, String previousHash, DateTime timestamp) {
    final content = "$index$data$previousHash$timestamp";
    return sha256.convert(utf8.encode(content)).toString();
  }
}
