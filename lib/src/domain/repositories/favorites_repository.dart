import 'package:dartz/dartz.dart';
import 'package:poke_app/src/core/errors/failure.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';

abstract class FavoritesRepository {
  Future<Either<Failure, List<Pokemon>>> getFavorites();
}