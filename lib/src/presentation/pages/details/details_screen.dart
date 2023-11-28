import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/src/presentation/blocs/blocs.dart';
import 'package:responsive_grid/responsive_grid.dart';

class DetailsScreen extends StatefulWidget {
  const DetailsScreen({
    Key? key,
    required this.id,
  }) : super(key: key);

  final String id;

  @override
  State<DetailsScreen> createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {

  late FavoritesCubit _favoritesCubit;

  @override
  void initState() {
    context.read<DetailsCubit>().getByName(widget.id);
    _favoritesCubit = context.read<FavoritesCubit>();
    _favoritesCubit.getAll();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurple,
      appBar: AppBar(
        title: Text('${widget.id.toUpperCase()}'),
        actions: [
          BlocBuilder<DetailsCubit, DetailsState>(
            builder: (context, state) {
              if (state is DetailsLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (state is DetailsHasData) {
                final pokemon = state.pokemon;

                return BlocBuilder<FavoritesCubit, FavoritesState>(
                  builder: (context, state) {
                    if (state is FavoritesLoading) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (state is  FavoritesHasList) {
                      return IconButton(
                          onPressed: (){
                            _favoritesCubit.toggleFavorite(pokemon, state.result);
                            _favoritesCubit.getAll();
                          },
                          icon: _favoritesCubit.hasFavorite(pokemon, state.result) ? Icon(Icons.favorite) : Icon(Icons.favorite_border)
                      );

                    } else if (state is FavoritesError) {
                      return SizedBox();
                    } else {
                      return SizedBox();
                    }
                  },
                );

              } else if (state is DetailsError) {
                return const SizedBox.shrink();
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<DetailsCubit, DetailsState>(
        builder: (context, state) {
          if (state is DetailsLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailsHasData) {
            final pokemon = state.pokemon;

            String imageURL = '';

            if (pokemon.id != null) {
              imageURL =
              'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/other/home/${pokemon.id}.png';
            }

            final image = CachedNetworkImage(
              imageUrl: imageURL,
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  Padding(
                    padding: EdgeInsets.only(bottom: 35, right: 30),
                    child: CircularProgressIndicator(value: downloadProgress.progress),
                  ),
              imageBuilder: (context, imageProvider) => Image(
                image: imageProvider,
                width: 350,
                height: 350,
                fit: BoxFit.cover,
              ),
              errorWidget: (context, url, error) => Padding(
                padding: EdgeInsets.only(bottom: 35, right: 30),
                child: Icon(Icons.error),
              ),
            );

            return SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: [
                      image,
                      Padding(
                        padding: EdgeInsets.only(top: 330),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      pokemon.id != null
                                          ? '#00${pokemon.id}'
                                          : '',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(width: 17),
                                    Text(
                                      pokemon.name != null
                                          ? pokemon.name!.toUpperCase()
                                          : '',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(top: 10),
                                  child: Row(
                                    children: [
                                      Text(
                                        pokemon.weight != null
                                            ? 'Peso: ${pokemon.weight}'
                                            : '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: 17),
                                      Text(
                                        pokemon.height != null
                                            ? 'Altura: ${pokemon.height}'
                                            : '',
                                        style: const TextStyle(
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                if(pokemon.types?.isNotEmpty == true)...[
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Tipos',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ResponsiveGridRow(
                                    children: pokemon.types!.map((types){
                                      return ResponsiveGridCol(
                                        xs: 6,
                                        md: 6,
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(right: 15, top: 10),
                                          padding: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(25)
                                          ),
                                          child: Text(
                                            '${types.name?.toUpperCase()}',
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  )
                                ],
                                if(pokemon.abilities?.isNotEmpty == true)...[
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Habilidades',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ResponsiveGridRow(
                                    children: pokemon.abilities!.map((types){
                                      return ResponsiveGridCol(
                                        xs: 6,
                                        md: 6,
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(right: 15, top: 10),
                                          padding: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(25)
                                          ),
                                          child: Text(
                                            '${types.name?.toUpperCase()}',
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  )
                                ],
                                if(pokemon.forms?.isNotEmpty == true)...[
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Formas',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ResponsiveGridRow(
                                    children: pokemon.forms!.map((types){
                                      return ResponsiveGridCol(
                                        xs: 6,
                                        md: 6,
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(right: 15, top: 10),
                                          padding: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(25)
                                          ),
                                          child: Text(
                                            '${types.name?.toUpperCase()}',
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  )
                                ],
                                if(pokemon.stats?.isNotEmpty == true)...[
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text(
                                      'Stats',
                                      style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  ResponsiveGridRow(
                                    children: pokemon.stats!.map((types){
                                      return ResponsiveGridCol(
                                        xs: 6,
                                        md: 6,
                                        child: Container(
                                          alignment: Alignment.center,
                                          margin: EdgeInsets.only(right: 15, top: 10),
                                          padding: EdgeInsets.only(left: 15, right: 15, bottom: 5, top: 5),
                                          decoration: BoxDecoration(
                                              border: Border.all(color: Colors.grey),
                                              borderRadius: BorderRadius.circular(25)
                                          ),
                                          child: Text(
                                            '${types.name?.toUpperCase()}',
                                          ),
                                        ),
                                      );
                                    }).toList(),
                                  )
                                ],
                                SizedBox(height: 50,)
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            );
          } else if (state is DetailsError) {
            return Center(
              child: Text('Error: ${state.message}'),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}