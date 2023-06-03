import 'package:flutter/material.dart';
import 'package:tf09c_0026_marvel_heroes_app/model/character.dart';
import 'package:tf09c_0026_marvel_heroes_app/model/character_list.dart';
import 'package:tf09c_0026_marvel_heroes_app/pages/character_details_page.dart';
import 'package:tf09c_0026_marvel_heroes_app/pages/core/Networking.dart';
import 'package:tf09c_0026_marvel_heroes_app/services/character_service.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late CharacterList? characterList;
  final PagingController<int, Character> _pagingController =
      PagingController(firstPageKey: 1);

  @override
  void initState() {
    // TODO: implement initState
    _pagingController.addPageRequestListener((pageKey) {
      _fetchPage(pageKey);
    });
    super.initState();
    // callHeroes();
  }

  Future<void> _fetchPage(int pageKey) async {
    const pageSize = 15;
    final characterService = CharacterService();
    final offset = (pageKey - 1) * pageSize;
    final newItems =
        await characterService.getCharacters(offset: offset, limit: pageSize);
    final isLastPage = newItems.result.length < pageSize;
    if (isLastPage) {
      _pagingController.appendLastPage(newItems.result);
    } else {
      final newPage = pageKey + 1;
      _pagingController.appendPage(newItems.result, newPage);
    }
    setState(() {});
  }

  // Future<void> callHeroes() async {
  //   // final network = Networking();
  //   // final data = await network.get(operationPath: '/v1/public/characters');
  //   final characterService = CharacterService();
  //   characterList = await characterService.getCharacters(offset: 20);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Marvel Heroes"),
      ),
      body: PagedListView<int, Character>(
        pagingController: _pagingController,
        builderDelegate: PagedChildBuilderDelegate(
          firstPageProgressIndicatorBuilder: (context) {
            return const SpinKitPouringHourGlassRefined(
              color: Colors.red,
              size: 80,
            );
          },
          newPageProgressIndicatorBuilder: (context) {
            return const SpinKitWaveSpinner(
              color: Colors.red,
              size: 80,
            );
          },
          itemBuilder: (context, character, index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(character.thumbnail),
              ),
              title: Text(character.name),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return CharacterDetailsPage(id: character.id);
                }));
              },
            );
          },
        ),
      ),
    );
    // if (characterList != null) {
    // }
    // return Scaffold(
    //   body: Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );
  }
}
