import 'package:dartz/dartz.dart';
import 'package:poke_app/src/core/errors/failure.dart';
import 'package:poke_app/src/core/use_case.dart';
import 'package:poke_app/src/domain/entities/types.dart';
import 'package:poke_app/src/domain/repositories/types_repository.dart';

class GetTypesList implements UseCaseTypes<List<Types>> {
  GetTypesList(this._repository);

  final TypesRepository _repository;

  @override
  Future<Either<Failure, List<Types>>> call() =>
      _repository.getTypesList();
}