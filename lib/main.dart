import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/bloc/person_bloc.dart';
import 'package:persons_app/data/provider/prerson_provider.dart';
import 'package:persons_app/data/repository/person_repository.dart';
import 'package:persons_app/screen/person_list_screen.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PersonsList',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: RepositoryProvider(create: (context) => PersonRepository(PersonProvider()),
        child: BlocProvider(
          create: (context) => PersonBloc(context.read<PersonRepository>()),
          child: const PersonListScreen(),
        ),
      ),
    );
  }
}
