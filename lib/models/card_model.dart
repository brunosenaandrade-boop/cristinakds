/// Modelo de cada carta do jogo
class CardModel {
  final int id;
  final String emoji;
  final int pairId;
  bool isFaceUp;
  bool isMatched;

  CardModel({
    required this.id,
    required this.emoji,
    required this.pairId,
    this.isFaceUp = false,
    this.isMatched = false,
  });
}
