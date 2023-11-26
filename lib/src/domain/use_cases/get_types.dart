import 'package:dartz/dartz.dart';
import 'package:poke_app/src/core/errors/failure.dart';
import 'package:poke_app/src/domain/entities/types.dart';
import 'package:poke_app/src/domain/repositories/types_repository.dart';

class GetTypes {
  const GetTypes(this.repository);

  final TypesRepository repository;

  Future<Either<Failure, List<Types>>> call(String name) =>
      repository.getTypes(name);
}