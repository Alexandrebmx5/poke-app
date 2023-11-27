import 'dart:convert';

import 'package:poke_app/src/core/errors/exceptions.dart';
import 'package:poke_app/src/core/network/client_service.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';
import 'package:poke_app/src/domain/entities/types.dart';


abstract class RemoteDataSource {
  Future<List<Pokemon>> getPokemonList(int limit, int offset);
  Future<List<Pokemon>> getPokemon(String name);
  Future<List<Types>> getTypesList();
  Future<List<Types>> getTypes(String name);
  Future<List<Pokemon>> getPokemonTypesList(List<Pokemon> pokemon);
}

class RemoteDataSourceImpl implements RemoteDataSource {
  RemoteDataSourceImpl({
    required this.client,
  });

  final ClientService client;

  @override
  Future<List<Pokemon>> getPokemonList(int limit, int offset) async {
    final response = await client.get('?limit=$limit&offset=$offset');

    if (response.statusCode == 200) {
      final results = json.decode(response.body)['results'] as List;
      final List<Pokemon> pokemonList = [];

      for (var i = 0; i < results.length; i++) {
        pokemonList.add((await getPokemon(results[i]['name']))[0]);
      }

      return pokemonList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Pokemon>> getPokemon(String name) async {
    final response = await client.get('/$name');

    if (response.statusCode == 200) {
      return [Pokemon.fromJson(response.body)];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Types>> getTypesList() async {
    final response = await client.getTypes(null);

    if (response.statusCode == 200) {
      final results = json.decode(response.body)['results'] as List;
      final List<Types> typesList = [];

      for (var i = 0; i < results.length; i++) {
        typesList.add((await getTypes(results[i]['name']))[0]);
      }

      return typesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Types>> getTypes(String name) async {
    final response = await client.getTypes('/$name');

    if (response.statusCode == 200) {
      return [Types.fromJsonTwo(response.body)];
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<Pokemon>> getPokemonTypesList(List<Pokemon> pokemon) async {
    final List<Pokemon> pokemonTypesList = [];

    for (var i = 0; i < pokemon.length; i++) {
      Pokemon pk = (await getPokemon(pokemon[i].name!))[0];
      if(pk.types!.length == 1){
        pokemonTypesList.add((await getPokemon(pokemon[i].name!))[0]);
      }
    }

    return pokemonTypesList;
  }
}