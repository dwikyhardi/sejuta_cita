class Capitalize {
  String call(String text) {
    String capitalizedWord = '';
    final List<String> words = text.split(' ');

    // Capitalize first letter of each words
    final capitalizedWords = words.map((word) {
      if (word.trim().isNotEmpty) {
        final String firstLetter = word.trim().substring(0, 1).toUpperCase();
        final String remainingLetters = word.trim().substring(1);

        return '$firstLetter$remainingLetters';
      } else {
        return '';
      }
    });

    for (var element in capitalizedWords) {
      capitalizedWord = '$capitalizedWord $element';
    }

    return capitalizedWord.trimLeft();
  }
}
