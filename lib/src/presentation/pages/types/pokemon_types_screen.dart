import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';
import 'package:poke_app/src/presentation/blocs/types/pokemon_types_cubit.dart';
import 'package:poke_app/src/presentation/blocs/types/pokemon_types_state.dart';
import 'package:poke_app/src/presentation/widgets/pokemon_card.dart';

class PokemonTypesScreen extends StatefulWidget {

  PokemonTypesScreen(this.pokemonList, this.nameType);

  final List<Pokemon> pokemonList;
  final String? nameType;

  @override
  State<PokemonTypesScreen> createState() => _PokemonTypesScreenState();
}

class _PokemonTypesScreenState extends State<PokemonTypesScreen> {
  late PokemonTypesCubit _pokemonTypesCubit;

  @override
  void initState() {
    super.initState();
    _pokemonTypesCubit = context.read<PokemonTypesCubit>();
    _pokemonTypesCubit.getAll(widget.pokemonList);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.nameType?.toUpperCase()}'),
      ),
      body: BlocBuilder<PokemonTypesCubit, PokemonTypesState>(
        builder: (context, state) {
          if (state is PokemonTypesLoading) {
            return const Center(child: const CircularProgressIndicator());
          } else if (state is PokemonTypesHasList) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: state.result.map((item){
                  return PokemonCard(pokemon: item);
                }).toList(),
              ),
            );
          } else if (state is PokemonTypesError) {
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