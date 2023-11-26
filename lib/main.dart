import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:poke_app/src/core/framework/router/router.dart';
import 'package:poke_app/src/presentation/blocs/details/details_cubit.dart';
import 'package:poke_app/src/presentation/blocs/pokemon/pokemon_cubit.dart';
import 'package:poke_app/src/injector.dart' as di;
import 'package:poke_app/src/presentation/blocs/types/pokemon_types_cubit.dart';
import 'package:poke_app/src/presentation/blocs/types/types_cubit.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.getIt<PokemonCubit>(),
        ),
        BlocProvider(
          create: (_) => di.getIt<DetailsCubit>(),
        ),
        BlocProvider(
          create: (_) => di.getIt<TypesCubit>(),
        ),
        BlocProvider(
          create: (_) => di.getIt<PokemonTypesCubit>(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Poke App',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: false,
        ),
        supportedLocales: [
          const Locale('pt'),
        ],
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        initialRoute: rootRoute,
        onGenerateRoute: RouterManager.generateRoute,
      ),
    );
  }
}