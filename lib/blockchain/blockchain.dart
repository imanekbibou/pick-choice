import 'block.dart';

class Blockchain {
  List<Block> chain = [];

  Blockchain() {
    chain.add(createGenesisBlock());
  }

  Block createGenesisBlock() {
    return Block(
      index: 0,
      data: "Genesis Block",
      previousHash: "0",
      hash: Block.calculateHash(0, "Genesis Block", "0", DateTime.now()),
      timestamp: DateTime.now(),
    );
  }

  void addBlock(String data) {
    final lastBlock = chain.last;
    final newIndex = lastBlock.index + 1;
    final timestamp = DateTime.now();

    final newHash = Block.calculateHash(
      newIndex,
      data,
      lastBlock.hash,
      timestamp,
    );

    chain.add(
      Block(
        index: newIndex,
        data: data,
        previousHash: lastBlock.hash,
        hash: newHash,
        timestamp: timestamp,
      ),
    );
  }
}

Blockchain myBlockchain = Blockchain();
