import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';
import 'package:poke_app/src/domain/use_cases/pokemon_types_list.dart';
import 'package:poke_app/src/presentation/blocs/types/pokemon_types_state.dart';

class PokemonTypesCubit extends Cubit<PokemonTypesState> {
  PokemonTypesCubit(this.getPokemonList) : super(PokemonTypesLoading());

  final GetPokemonTypesList getPokemonList;

  Future<void> getAll(List<Pokemon> pokemon) async {
    emit(PokemonTypesLoading());
    final result = await getPokemonList.call(pokemon);

    result.fold(
          (failure) {
        emit(PokemonTypesError(failure.message));
      },
          (data) {
        emit(PokemonTypesHasList(data));
      },
    );
  }
}