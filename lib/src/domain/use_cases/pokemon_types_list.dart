import 'package:dartz/dartz.dart';
import 'package:poke_app/src/core/errors/failure.dart';
import 'package:poke_app/src/core/use_case.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';
import 'package:poke_app/src/domain/repositories/pokemon_types_repository.dart';

class GetPokemonTypesList implements UseCasePokemonTypes<List<Pokemon>, List<Pokemon>> {
  GetPokemonTypesList(this._repository);

  final PokemonTypesRepository _repository;

  @override
  Future<Either<Failure, List<Pokemon>>> call(List<Pokemon> pokemon) =>
      _repository.getPokemonTypesList(pokemon);
}