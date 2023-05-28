import 'package:tf09c_0026_marvel_heroes_app/model/character_list.dart';
import 'package:tf09c_0026_marvel_heroes_app/pages/core/Networking.dart';

class CharacterService {
  final _basePath = '/v1/public/characters';

  Future<CharacterList> getCharacters() async {
    final networking = Networking();
    final response = await networking.get(
      operationPath: _basePath,
      // params: {
      //   'offset': offset,
      //   'limit': limit,
      // },
    );
    final data = response['data'];
    return CharacterList.fromJson(data);
  }
}
