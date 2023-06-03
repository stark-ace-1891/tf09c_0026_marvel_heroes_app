import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:tf09c_0026_marvel_heroes_app/model/character_details.dart';
import 'package:tf09c_0026_marvel_heroes_app/services/character_service.dart';

class CharacterDetailsPage extends StatefulWidget {
  final int id;

  CharacterDetailsPage({super.key, required this.id});

  @override
  State<CharacterDetailsPage> createState() => _CharacterDetailsPageState();
}

class _CharacterDetailsPageState extends State<CharacterDetailsPage> {
  CharacterDetails? details;

  @override
  void initState() {
    super.initState();
    getDetails(id: widget.id);
  }

  Future<void> getDetails({required int id}) async {
    final service = CharacterService();
    final serviceDetailsResponse =
        await service.getCharacterDetails(characterId: id);
    setState(() {
      details = serviceDetailsResponse;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (details == null) {
      // return CircularProgressIndicator();
      return Scaffold(
        body: Center(
          child: SpinKitPouringHourGlassRefined(
            color: Colors.red,
            size: 80,
          ),
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text("Details"),
        ),
        body: ListView(
          children: [
            Text(
              details?.name ?? '',
            ),
          ],
        ),
      );
    }
  }
}
