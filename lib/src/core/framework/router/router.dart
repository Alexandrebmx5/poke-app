import 'package:flutter/material.dart';
import 'package:poke_app/src/presentation/pages/base/base_screen.dart';
import 'package:poke_app/src/presentation/pages/details/details_screen.dart';
import 'package:poke_app/src/presentation/pages/types/pokemon_types_screen.dart';

const String rootRoute = "/";
const String detailsRoute = "/details";
const String pokemonTypeRoute = "/pokemon_type";
class RouterManager {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case rootRoute:
        return MaterialPageRoute(builder: (context) => BaseScreen());
      case detailsRoute:
        return MaterialPageRoute(builder: (context) => DetailsScreen(
            id: settings.arguments as String
        ));
      case pokemonTypeRoute:
        Map<String, dynamic> arg = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(builder: (context) => PokemonTypesScreen(
            arg['pokemonList'], arg['nameType']
        ));
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
              body: Center(
                  child: Text('No route defined for ${settings.name}')),
            ));
    }
  }
}