import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/src/domain/use_cases/get_types.dart';
import 'package:poke_app/src/domain/use_cases/types_list.dart';
import 'package:poke_app/src/presentation/blocs/types/types_state.dart';

class TypesCubit extends Cubit<TypesState> {
  TypesCubit(this.getTypesList, this.getTypes) : super(TypesLoading());

  final GetTypesList getTypesList;
  final GetTypes getTypes;

  Future<void> getAll(int offset) async {
    final result =
    await getTypesList.call();

    result.fold(
          (failure) {
        emit(TypesError(failure.message));
      },
          (data) {
        emit(TypesHasList(data, offset));
      },
    );
  }

  Future<void> getByName(String name) async {
    final result = await getTypes.call(name);

    result.fold(
          (failure) {
        emit(TypesError(failure.message));
      },
          (data) {
        emit(TypesHasList(data, 0));
      },
    );
  }
}