import 'package:dartz/dartz.dart';
import 'package:poke_app/src/core/errors/failure.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';

abstract class PokemonTypesRepository {
  Future<Either<Failure, List<Pokemon>>> getPokemonTypesList(List<Pokemon> pokemon);
}