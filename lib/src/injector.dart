import 'package:get_it/get_it.dart';
import 'package:poke_app/src/core/network/client_service.dart';
import 'package:poke_app/src/data/data_sources/remote_data_source.dart';
import 'package:poke_app/src/data/repositories/pokemon_repository_impl.dart';
import 'package:poke_app/src/data/repositories/pokemon_types_repository_impl.dart';
import 'package:poke_app/src/data/repositories/types_repository_impl.dart';
import 'package:poke_app/src/domain/repositories/pokemon_repository.dart';
import 'package:poke_app/src/domain/repositories/pokemon_types_repository.dart';
import 'package:poke_app/src/domain/repositories/types_repository.dart';
import 'package:poke_app/src/domain/use_cases/get_pokemon.dart';
import 'package:poke_app/src/domain/use_cases/get_types.dart';
import 'package:poke_app/src/domain/use_cases/pokemon_list.dart';
import 'package:poke_app/src/domain/use_cases/pokemon_types_list.dart';
import 'package:poke_app/src/domain/use_cases/types_list.dart';
import 'package:poke_app/src/presentation/blocs/details/details_cubit.dart';
import 'package:poke_app/src/presentation/blocs/pokemon/pokemon_cubit.dart';
import 'package:poke_app/src/presentation/blocs/types/pokemon_types_cubit.dart';
import 'package:poke_app/src/presentation/blocs/types/types_cubit.dart';

final getIt = GetIt.instance;

void init() {
  // Core
  getIt
    ..registerLazySingleton(() => ClientService())

  // Use case
    ..registerLazySingleton(() => GetPokemonList(getIt()))
    ..registerLazySingleton(() => GetPokemon(getIt()))
    ..registerLazySingleton(() => GetTypesList(getIt()))
    ..registerLazySingleton(() => GetTypes(getIt()))
    ..registerLazySingleton(() => GetPokemonTypesList(getIt()))

  // BLoC
    ..registerFactory(() => PokemonCubit(getIt(), getIt()))
    ..registerFactory(() => DetailsCubit(getIt()))
    ..registerFactory(() => TypesCubit(getIt(), getIt()))
    ..registerFactory(() => PokemonTypesCubit(getIt()))

  // Repository
    ..registerLazySingleton<PokemonRepository>(() => PokemonRepositoryImpl(
      remoteDataSource: getIt(),
    ))
    ..registerLazySingleton<TypesRepository>(() => TypesRepositoryImpl(
      remoteDataSource: getIt(),
    ))
    ..registerLazySingleton<PokemonTypesRepository>(() => PokemonTypesRepositoryImpl(
      remoteDataSource: getIt(),
    ))

  // Data sources
    ..registerLazySingleton<RemoteDataSource>(
            () => RemoteDataSourceImpl(client: getIt()));
}