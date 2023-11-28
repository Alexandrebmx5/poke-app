import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/src/core/framework/database/database.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';
import 'package:poke_app/src/domain/use_cases/get_favorites.dart';
import 'package:poke_app/src/presentation/blocs/favorites/favorites_state.dart';

class FavoritesCubit extends Cubit<FavoritesState> {
  FavoritesCubit(this.getFavorites) : super(FavoritesLoading());

  final GetFavorites getFavorites;

  Future<void> getAll() async {
    emit(FavoritesLoading());
    final result = await getFavorites.call();

    result.fold(
          (failure) {
        emit(FavoritesError(failure.message));
      },
          (data) {
        emit(FavoritesHasList(data));
      },
    );
  }

  Future<void> toggleFavorite(Pokemon pokemon, List<Pokemon> pokemonList) async {
    try {
      if (pokemonList.any((a) => a.id == pokemon.id)) {
        pokemonList.removeWhere((a) => a.id == pokemon.id);
        List<String> pks = pokemonList.map((e) => e.toJson()).toList();
        await DatabaseManager().setStringListForKey(pks, 'favorites');
      } else {
        pokemonList.add(pokemon);
        List<String> pks = pokemonList.map((e) => e.toJson()).toList();
        await DatabaseManager().setStringListForKey(pks, 'favorites');
      }

    } catch (e) {
      print(e);
    }
  }

  bool hasFavorite(Pokemon pokemon, List<Pokemon> pokemonList) {
    try {
      if (pokemonList.any((a) => a.id == pokemon.id)) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }
}