import 'package:flutter/material.dart';
import 'package:tf09c_0026_marvel_heroes_app/model/character_list.dart';
import 'package:tf09c_0026_marvel_heroes_app/pages/core/Networking.dart';
import 'package:tf09c_0026_marvel_heroes_app/services/character_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CharacterList? characterList;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callHeroes();
  }

  Future<void> callHeroes() async {
    // final network = Networking();
    // final data = await network.get(operationPath: '/v1/public/characters');
    try {
      final characterService = CharacterService();
      characterList = await characterService.getCharacters();
      setState(() {});
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    if (characterList != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Marvel Heroes"),
        ),
        body: ListView.builder(
          itemCount: characterList!.result.length,
          itemBuilder: (context, index) {
            final characterItem = characterList!.result[index];
            return ListTile(
              title: Text(characterItem.name),
              leading: CircleAvatar(
                backgroundImage: NetworkImage(characterItem.thumbnail),
              ),
            );
          },
        ),
      );
    }
    return Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
