import 'package:flutter/material.dart';
import 'package:poke_app/src/core/framework/router/router.dart';
import 'package:poke_app/src/domain/entities/types.dart';

class TypesCard extends StatelessWidget {
  const TypesCard({
    Key? key,
    required this.types,
  }) : super(key: key);

  final Types types;

  @override
  Widget build(BuildContext context) {

    final bgColor = (Colors.black26).withAlpha(150);

    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamed(pokemonTypeRoute, arguments: {
            "pokemonList": types.pokemon,
            "nameType": types.name
          });
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
                    Text(
                      types.name != null
                          ? types.name!.toUpperCase()
                          : '',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}