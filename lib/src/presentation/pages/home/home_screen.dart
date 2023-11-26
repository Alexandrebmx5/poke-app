import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';
import 'package:poke_app/src/presentation/blocs/blocs.dart';
import 'package:poke_app/src/presentation/drawer/side_menu.dart';
import 'package:poke_app/src/presentation/widgets/pokemon_card.dart';
import 'package:poke_app/src/presentation/widgets/search_pokemon.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _limit = 20;
  String? searchName;

  final PagingController<int, Pokemon> _pagingController =
  PagingController(firstPageKey: 0);

  late PokemonCubit _pokemonCubit;

  @override
  void initState() {
    super.initState();
    _pokemonCubit = context.read<PokemonCubit>();

    _pokemonCubit.getAll(_limit, 0);
    _pagingController.addPageRequestListener(
            (pageKey) => _pokemonCubit.getAll(_limit, pageKey));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: const Text('Poke App'),
      ),
      body: BlocListener<PokemonCubit, PokemonState>(
        listener: (context, state) {
          if (state is PokemonHasList) {
            if (state.result.length < _limit) {
              _pagingController.appendLastPage(state.result);
            } else if(searchName == null || searchName == '') {
              final nextPageKey = state.offset + state.result.length;
              _pagingController.appendPage(state.result, nextPageKey);
            }
          } else if (state is PokemonError) {
            _pagingController.error = state.message;
          }
        },
        child: BlocBuilder<PokemonCubit, PokemonState>(
          builder: (context, state) {
            if (state is PokemonLoading) {
              return const Center(child: const CircularProgressIndicator());
            } else if (state is PokemonHasList) {
              return Column(
                children: [
                  SearchPokemon(
                    onChanged: _updateSearch,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: PagedListView<int, Pokemon>(
                      pagingController: _pagingController,
                      builderDelegate: PagedChildBuilderDelegate(
                        itemBuilder: (_, item, __) {
                          if(item.id != null)
                            return PokemonCard(pokemon: item);
                          else
                            return SizedBox();
                        }
                      ),
                    ),
                  ),
                ],
              );
            } else if (state is PokemonError) {
              return Column(
                children: [
                  SearchPokemon(
                    onChanged: _updateSearch,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                      child: Center(child: Text('Error: ${state.message}')
                      )
                  ),
                ],
              );
            } else {
              return Column(
                children: [
                  SearchPokemon(
                    onChanged: _updateSearch,
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                      child: Center(child: Text('No data'))
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  void _updateSearch(String name) {

    setState(() {
      searchName = name;
    });

    _pokemonCubit.getByName(name);
    _pagingController.refresh();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}