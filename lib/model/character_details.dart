class CharacterDetails {
  final String name;
  final String thumbnail;
  final String? description;
  final List<String> comics;

  CharacterDetails({
    required this.name,
    required this.thumbnail,
    required this.comics,
    this.description,
  });
  factory CharacterDetails.fromJson(Map<String, dynamic> json) {
    final result = json['results'][0];
    return CharacterDetails(
      name: result['name'],
      thumbnail:
          "${result['thumbnail']['path']}.${result['thumbnail']['extension']}",
      comics: List<String>.from(
        (result['comics']['items'] as List<dynamic>).map<String>(
          (comic) => comic['name'],
        ),
      ),
    );
  }
}
