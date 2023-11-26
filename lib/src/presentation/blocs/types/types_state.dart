import 'package:equatable/equatable.dart';
import 'package:poke_app/src/domain/entities/types.dart';

abstract class TypesState extends Equatable {
  const TypesState([this._props = const []]);

  final List<Object?> _props;

  @override
  List<Object?> get props => [_props];
}

class TypesLoading extends TypesState {}

class TypesError extends TypesState {
  TypesError(this.message) : super([message]);
  final String message;
}

class TypesHasList extends TypesState {
  TypesHasList(this.result, this.offset) : super([result, offset]);

  final List<Types> result;
  final int offset;
}