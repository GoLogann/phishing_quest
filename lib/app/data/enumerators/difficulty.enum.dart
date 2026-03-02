enum Difficulty {
  easy,
  medium,
  hard;

  String get label {
    switch (this) {
      case Difficulty.easy:
        return 'Fácil';
      case Difficulty.medium:
        return 'Médio';
      case Difficulty.hard:
        return 'Difícil';
    }
  }

  static Difficulty fromString(String value) {
    return Difficulty.values.firstWhere(
      (e) => e.name == value.toLowerCase(),
      orElse: () => Difficulty.medium,
    );
  }
}
