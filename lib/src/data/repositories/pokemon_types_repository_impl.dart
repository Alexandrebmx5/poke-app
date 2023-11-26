import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:poke_app/src/core/errors/exceptions.dart';
import 'package:poke_app/src/core/errors/failure.dart';
import 'package:poke_app/src/data/data_sources/remote_data_source.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';
import 'package:poke_app/src/domain/repositories/pokemon_types_repository.dart';

class PokemonTypesRepositoryImpl implements PokemonTypesRepository {
  PokemonTypesRepositoryImpl({
    required this.remoteDataSource,
  });

  final RemoteDataSource remoteDataSource;

  Future<Either<Failure, List<Pokemon>>> getPokemonTypesList(List<Pokemon> pokemon) async {
    try {
      final remotePokemonList =
      await remoteDataSource.getPokemonTypesList(pokemon);
      return Right(remotePokemonList);
    } on ServerException {
      return const Left(ServerFailure('Failed to get pokemon list'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}