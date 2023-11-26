import 'package:dartz/dartz.dart';
import 'package:poke_app/src/core/errors/failure.dart';
import 'package:poke_app/src/core/params/pokemon_params.dart';
import 'package:poke_app/src/core/use_case.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';
import 'package:poke_app/src/domain/repositories/pokemon_repository.dart';

class GetPokemonList implements UseCase<List<Pokemon>, PokemonParam> {
  GetPokemonList(this._repository);

  final PokemonRepository _repository;

  @override
  Future<Either<Failure, List<Pokemon>>> call(PokemonParam params) =>
      _repository.getPokemonList(params);
}