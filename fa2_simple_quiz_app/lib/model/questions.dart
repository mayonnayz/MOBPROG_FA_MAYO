class Questions {
  const Questions(this.text, this.choices);

  final String text;
  final List<String> choices;

  (List<String>, String) getShuffledList() {
    final String correctAnswer = choices[0];
    final shuffledList = List<String>.from(choices);
    shuffledList.shuffle();

    return (shuffledList, correctAnswer);
  }
}