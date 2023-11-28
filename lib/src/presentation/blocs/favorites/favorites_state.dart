import 'package:equatable/equatable.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';

abstract class FavoritesState extends Equatable {
  const FavoritesState([this._props = const []]);

  final List<Object?> _props;

  @override
  List<Object?> get props => [_props];
}

class FavoritesLoading extends FavoritesState {}

class FavoritesError extends FavoritesState {
  FavoritesError(this.message) : super([message]);
  final String message;
}

class FavoritesHasList extends FavoritesState {
  FavoritesHasList(this.result) : super([result]);

  final List<Pokemon> result;
}