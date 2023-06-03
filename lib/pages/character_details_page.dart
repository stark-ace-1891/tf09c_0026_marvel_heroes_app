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
  // CharacterDetails? details;
  final service = CharacterService();

  // @override
  // void initState() {
  //   super.initState();
  //   getDetails(id: widget.id);
  // }

  // Future<void> getDetails({required int id}) async {
  //   final service = CharacterService();
  //   final serviceDetailsResponse =
  //       await service.getCharacterDetails(characterId: id);
  //   setState(() {
  //     details = serviceDetailsResponse;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Details"),
      ),
      body: FutureBuilder(
        future: service.getCharacterDetails(characterId: widget.id),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Column(
              children: [
                Container(
                  width: 411,
                  height: 411,
                  color: Colors.grey,
                ),
                SizedBox(
                  height: 8,
                ),
                Center(
                  child: SpinKitPouringHourGlassRefined(
                    color: Colors.red,
                    size: 80,
                  ),
                )
              ],
            );
          } else if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasData) {
              final details = snapshot.data;
              if (details != null) {
                return ListView(
                  children: [
                    Image.network(details.thumbnail),
                    Text(
                      details.name,
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 8,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Descripcion",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            details.description == ''
                                ? "No hay descripcion disponible"
                                : details.description,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            "Comics en los que aparece",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          ...details.comics.map((comic) {
                            return Text("- $comic");
                          }).toList(),
                        ],
                      ),
                    ),
                  ],
                );
              } else {
                return Text("No hay data");
              }
            }
          }
          return Text("Ocurrio un error");
        },
      ),
    );
  }
}
