import 'package:dartz/dartz.dart';
import 'package:poke_app/src/core/errors/failure.dart';

abstract class UseCase<T, P> {
  Future<Either<Failure, T>> call(P params);
}

abstract class UseCaseTypes<T> {
  Future<Either<Failure, T>> call();
}

abstract class UseCasePokemonTypes<T, P> {
  Future<Either<Failure, T>> call(P pokemon);
}