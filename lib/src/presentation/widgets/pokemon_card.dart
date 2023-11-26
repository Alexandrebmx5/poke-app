import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:poke_app/src/core/framework/router/router.dart';
import 'package:poke_app/src/domain/entities/pokemon.dart';
import 'package:responsive_grid/responsive_grid.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  final Pokemon pokemon;

  @override
  Widget build(BuildContext context) {
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
        width: 120,
        height: 120,
        fit: BoxFit.cover,
      ),
      errorWidget: (context, url, error) => Padding(
        padding: EdgeInsets.only(bottom: 35, right: 30),
        child: Icon(Icons.error),
      ),
    );

    return FutureBuilder<Color>(
        future: _getImagePalette(NetworkImage(image.imageUrl)),
        builder: (_, snapshot) {
          final bgColor = (snapshot.data ?? Colors.black26).withAlpha(150);

          return ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(detailsRoute, arguments: pokemon.name);
              },
              child: Card(
                margin: const EdgeInsets.all(6),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                elevation: 2,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Stack(
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  fit: StackFit.loose,
                  children: [
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Transform.rotate(
                        angle: -0.1,
                        child: image,
                      ),
                    ),
                    Positioned(
                      left: 0,
                      top: 0,
                      bottom: 0,
                      width: 6,
                      child: Container(
                        color: bgColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20.0,
                        vertical: 16.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                pokemon.id != null
                                    ? '#00${pokemon.id}'
                                    : '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(width: 17),
                              Text(
                                pokemon.name != null
                                    ? pokemon.name!.toUpperCase()
                                    : '',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 16),
                          if(pokemon.types?.isNotEmpty == true)...[
                            ResponsiveGridRow(
                              children: pokemon.types!.map((types){
                                return ResponsiveGridCol(
                                  xs: 4,
                                  md: 4,
                                  child: Container(
                                    alignment: Alignment.center,
                                    margin: EdgeInsets.only(right: 15),
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
                          ]
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  // Calculate dominant color from ImageProvider
  Future<Color> _getImagePalette(ImageProvider? imageProvider) async {
    final paletteGenerator =
    await PaletteGenerator.fromImageProvider(imageProvider!);

    return paletteGenerator.dominantColor?.color ?? Colors.black26;
  }
}