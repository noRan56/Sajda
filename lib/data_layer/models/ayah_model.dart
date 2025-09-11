class Ayah {
  final int number;
  final int numberInSurah;
  final String text;

  Ayah({required this.number, required this.numberInSurah, required this.text});

  factory Ayah.fromJson(Map<String, dynamic> json) {
    return Ayah(
      number: json['number'],
      numberInSurah: json['numberInSurah'],
      text: json['text'],
    );
  }
}
