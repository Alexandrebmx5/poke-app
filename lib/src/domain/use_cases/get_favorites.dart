import 'package:dartz/dartz.dart';
import 'package:poke_app/src/core/errors/failure.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';
import 'package:poke_app/src/domain/repositories/favorites_repository.dart';

class GetFavorites {
  const GetFavorites(this.repository);

  final FavoritesRepository repository;

  Future<Either<Failure, List<Pokemon>>> call() =>
      repository.getFavorites();
}