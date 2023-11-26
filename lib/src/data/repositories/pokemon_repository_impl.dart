import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:poke_app/src/core/errors/exceptions.dart';
import 'package:poke_app/src/core/errors/failure.dart';
import 'package:poke_app/src/core/params/pokemon_params.dart';
import 'package:poke_app/src/data/data_sources/remote_data_source.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';
import 'package:poke_app/src/domain/repositories/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  PokemonRepositoryImpl({
    required this.remoteDataSource,
  });

  final RemoteDataSource remoteDataSource;

  Future<Either<Failure, List<Pokemon>>> getPokemonList(
      PokemonParam params) async {
    try {
      final remotePokemonList =
      await remoteDataSource.getPokemonList(params.limit, params.offset);
      return Right(remotePokemonList);
    } on ServerException {
      return const Left(ServerFailure('Failed to get pokemon list'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  Future<Either<Failure, List<Pokemon>>> getPokemon(String name) async {
    try {
      final remotePokemon = await remoteDataSource.getPokemon(name);
      return Right(remotePokemon);
    } on ServerException {
      return const Left(ServerFailure('No data found'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}