
List<String> generateCards(int pairCount) {
  List<String> cards = [];
  for (int i = 0; i < pairCount; i++) {
    cards.add(
        'assets/images/card_$i.png'); // Reemplaza con las rutas de tus imágenes
  }
  return cards * 2; // Duplica las cartas para hacer pares
}
