import 'package:flutter/material.dart';
import 'package:tf09c_0026_marvel_heroes_app/pages/core/Networking.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callHeroes();
  }

  void callHeroes() async {
    final network = Networking();
    final data = await network.get(operationPath: '/v1/public/characters');
    print(data);
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
