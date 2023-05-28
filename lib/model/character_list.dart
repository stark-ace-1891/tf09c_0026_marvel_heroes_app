import 'package:tf09c_0026_marvel_heroes_app/model/character.dart';

class CharacterList {
  final int offset;
  final int limit;
  final int total;
  final int count;
  final List<Character> result;

  CharacterList({
    required this.offset,
    required this.limit,
    required this.total,
    required this.count,
    required this.result,
  });

  factory CharacterList.fromJson(Map<String, dynamic> json) {
    // //1ra forma con for
    // List<Character> list = [];
    // for (var element in json['results'] as List<dynamic>) {
    //   list.add(Character.fromJson(element as Map<String, dynamic>));
    // }

    //2da forma usando map (recomendada)
    return CharacterList(
      offset: json['offset'],
      limit: json['limit'],
      total: json['total'],
      count: json['count'],
      result: List<Character>.from(
        (json['results'] as List<dynamic>).map<Character>(
          (element) => Character.fromJson(element as Map<String, dynamic>),
        ),
      ),
    );
  }
}
