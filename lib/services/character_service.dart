import 'package:tf09c_0026_marvel_heroes_app/model/character_details.dart';
import 'package:tf09c_0026_marvel_heroes_app/model/character_list.dart';
import 'package:tf09c_0026_marvel_heroes_app/pages/core/Networking.dart';

class CharacterService {
  final _basePath = '/v1/public/characters';

  Future<CharacterList> getCharacters({
    int offset = 0,
    int limit = 0,
  }) async {
    final networking = Networking();
    final response = await networking.get(
      operationPath: _basePath,
      params: {
        'offset': offset,
        'limit': limit,
      },
    );
    final data = response['data'];
    return CharacterList.fromJson(data);
  }

  Future<CharacterDetails> getCharacterDetails(
      {required int characterId}) async {
    final networking = Networking();
    final response =
        await networking.get(operationPath: "$_basePath/$characterId");
    final data = response['data'];
    return CharacterDetails.fromJson(data);
  }
}
