import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:poke_app/src/core/errors/exceptions.dart';
import 'package:poke_app/src/core/errors/failure.dart';
import 'package:poke_app/src/data/data_sources/local_data_source.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';
import 'package:poke_app/src/domain/repositories/favorites_repository.dart';

class FavoritesRepositoryImpl implements FavoritesRepository {
  FavoritesRepositoryImpl({
    required this.localDataSource,
  });

  final LocalDataSource localDataSource;

  Future<Either<Failure, List<Pokemon>>> getFavorites() async {
    try {
      final remotePokemonList = await localDataSource.getFavorites();
      return Right(remotePokemonList);
    } on ServerException {
      return const Left(ServerFailure('Failed to get pokemon list'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}