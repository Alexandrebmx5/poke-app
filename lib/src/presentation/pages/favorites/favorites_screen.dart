import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/src/presentation/blocs/blocs.dart';
import 'package:poke_app/src/presentation/drawer/side_menu.dart';
import 'package:poke_app/src/presentation/widgets/pokemon_card.dart';

class FavoritesScreen extends StatefulWidget {

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  late FavoritesCubit _favoritesCubit;

  @override
  void initState() {
    super.initState();
    _favoritesCubit = context.read<FavoritesCubit>();
    _favoritesCubit.getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: Text('Favoritos'),
      ),
      body: BlocBuilder<FavoritesCubit, FavoritesState>(
        builder: (context, state) {
          if (state is FavoritesLoading) {
            return const Center(child: const CircularProgressIndicator());
          } else if (state is FavoritesHasList) {
            if(state.result.isEmpty)
              return Center(child: Text('Nenhuma favorito encontrado!'));
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: state.result.map((item){
                  return PokemonCard(pokemon: item);
                }).toList(),
              ),
            );
          } else if (state is FavoritesError) {
            return Center(child: Text('Error: ${state.message}')
            );
          } else {
            return Center(child: Text('No data'));
          }
        },
      ),
    );
  }
}