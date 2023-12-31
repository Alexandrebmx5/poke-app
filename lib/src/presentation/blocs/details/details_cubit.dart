import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/src/domain/use_cases/get_pokemon.dart';
import 'package:poke_app/src/presentation/blocs/details/details_state.dart';

class DetailsCubit extends Cubit<DetailsState> {
  DetailsCubit(this.getPokemon) : super(DetailsLoading());

  final GetPokemon getPokemon;

  void getByName(String name) async {
    final result = await getPokemon.call(name);

    result.fold(
          (failure) {
        emit(DetailsError(failure.message));
      },
          (data) {
        emit(DetailsHasData(data[0]));
      },
    );
  }
}