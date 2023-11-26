import 'package:dartz/dartz.dart';
import 'package:poke_app/src/core/errors/failure.dart';
import 'package:poke_app/src/domain/entities/types.dart';

abstract class TypesRepository {
  Future<Either<Failure, List<Types>>> getTypesList();
  Future<Either<Failure, List<Types>>> getTypes(String name);
}