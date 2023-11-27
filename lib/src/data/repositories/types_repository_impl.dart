import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:poke_app/src/core/errors/exceptions.dart';
import 'package:poke_app/src/core/errors/failure.dart';
import 'package:poke_app/src/data/data_sources/remote_data_source.dart';
import 'package:poke_app/src/domain/entities/types.dart';
import 'package:poke_app/src/domain/repositories/types_repository.dart';

class TypesRepositoryImpl implements TypesRepository {
  TypesRepositoryImpl({
    required this.remoteDataSource,
  });

  final RemoteDataSource remoteDataSource;

  Future<Either<Failure, List<Types>>> getTypesList() async {
    try {
      final remotePokemonList =
      await remoteDataSource.getTypesList();
      return Right(remotePokemonList);
    } on ServerException {
      return const Left(ServerFailure('Failed to get types list'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }

  Future<Either<Failure, List<Types>>> getTypes(String name) async {
    try {
      final remoteTypes = await remoteDataSource.getTypes(name);
      return Right(remoteTypes);
    } on ServerException {
      return const Left(ServerFailure('No data found'));
    } on SocketException {
      return const Left(ConnectionFailure('Failed to connect to the network'));
    }
  }
}