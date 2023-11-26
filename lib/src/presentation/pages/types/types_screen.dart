import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poke_app/src/presentation/blocs/blocs.dart';
import 'package:poke_app/src/presentation/drawer/side_menu.dart';
import 'package:poke_app/src/presentation/widgets/types_card.dart';

class TypesScreen extends StatefulWidget {
  const TypesScreen({super.key});

  @override
  State<TypesScreen> createState() => _TypesScreenState();
}

class _TypesScreenState extends State<TypesScreen> {
  late TypesCubit _typesCubit;

  @override
  void initState() {
    super.initState();
    _typesCubit = context.read<TypesCubit>();
    _typesCubit.getAll(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideMenu(),
      appBar: AppBar(
        title: const Text('Tipos de Pokemon'),
      ),
      body: BlocBuilder<TypesCubit, TypesState>(
        builder: (context, state) {
          if (state is TypesLoading) {
            return const Center(child: const CircularProgressIndicator());
          } else if (state is TypesHasList) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: state.result.map((item){
                  return TypesCard(types: item);
                }).toList(),
              ),
            );
          } else if (state is TypesError) {
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
