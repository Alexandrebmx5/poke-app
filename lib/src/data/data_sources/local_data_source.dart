import 'package:poke_app/src/core/errors/exceptions.dart';
import 'package:poke_app/src/core/framework/database/database.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';


abstract class LocalDataSource {
  Future<List<Pokemon>> getFavorites();
}

class LocalDataSourceImpl implements LocalDataSource {
  LocalDataSourceImpl({
    required this.databaseManager,
  });

  final DatabaseManager databaseManager;

  @override
  Future<List<Pokemon>> getFavorites() async {
    try {
      final response = await databaseManager.valueListForKey('favorites');
      final List<Pokemon> pokemonList = [];
      if(response != null)  pokemonList.addAll(response.map((e) => Pokemon.fromJsonFavorites(e)).toList());
      return pokemonList;
    } catch(e){
      throw ServerException();
    }
  }
}