import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/src/core/params/pokemon_params.dart';
import 'package:poke_app/src/domain/use_cases/get_pokemon.dart';
import 'package:poke_app/src/domain/use_cases/pokemon_list.dart';
import 'package:poke_app/src/presentation/blocs/pokemon/pokemon_state.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit(this.getPokemonList, this.getPokemon) : super(PokemonLoading());

  final GetPokemonList getPokemonList;
  final GetPokemon getPokemon;

  Future<void> getAll(int limit, int offset) async {
    final result =
    await getPokemonList.call(PokemonParam(limit: limit, offset: offset));

    result.fold(
          (failure) {
        emit(PokemonError(failure.message));
      },
          (data) {
        emit(PokemonHasList(data, offset));
      },
    );
  }

  Future<void> getByName(String name) async {
    final result = await getPokemon.call(name);
    result.fold(
          (failure) {
        emit(PokemonError(failure.message));
      },
          (data) {
        emit(PokemonHasList(data, 0));
      },
    );
  }
}