import 'package:equatable/equatable.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';

abstract class PokemonTypesState extends Equatable {
  const PokemonTypesState([this._props = const []]);

  final List<Object?> _props;

  @override
  List<Object?> get props => [_props];
}

class PokemonTypesLoading extends PokemonTypesState {}

class PokemonTypesError extends PokemonTypesState {
  PokemonTypesError(this.message) : super([message]);
  final String message;
}

class PokemonTypesHasList extends PokemonTypesState {
  PokemonTypesHasList(this.result) : super([result]);

  final List<Pokemon> result;
}