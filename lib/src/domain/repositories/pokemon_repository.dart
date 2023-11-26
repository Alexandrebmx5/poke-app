import 'package:dartz/dartz.dart';
import 'package:poke_app/src/core/errors/failure.dart';
import 'package:poke_app/src/core/params/pokemon_params.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';

abstract class PokemonRepository {
  Future<Either<Failure, List<Pokemon>>> getPokemonList(PokemonParam params);
  Future<Either<Failure, List<Pokemon>>> getPokemon(String name);
}