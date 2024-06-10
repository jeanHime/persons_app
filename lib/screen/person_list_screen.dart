import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/bloc/person_bloc.dart';
import 'package:persons_app/screen/person_detail_screen.dart';
import 'package:persons_app/bloc/person_event.dart';
import 'package:persons_app/bloc/person_state.dart';
import '../data/model/person_model.dart';

import 'package:flutter/foundation.dart' show kIsWeb;

class PersonListScreen extends StatefulWidget {
  const PersonListScreen({super.key});

  @override
  State<PersonListScreen> createState() => _PersonListScreenState();
}

class _PersonListScreenState extends State<PersonListScreen> {
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    scrollController.addListener((){
      if(scrollController.position.maxScrollExtent == scrollController.offset){
        context.read<PersonBloc>().add(LoadMoreEvent());
      }
    });
  }


  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("PersonsList"),
        actions: [
          if(kIsWeb)...{
            IconButton(
              onPressed: () {
                context.read<PersonBloc>().add(LoadInitialListEvent());
              },
              icon: const Icon(Icons.refresh),
            ),
          }
        ],
      ),
      body: BlocBuilder<PersonBloc,PersonState>(
          builder: (context, state){
            if (state is PersonInitialState) {
              context.read<PersonBloc>().add(LoadInitialListEvent());
              return const SizedBox();
            }
            if (state is PersonLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is PersonErrorState) {
              Center(
                child: Text("Error: ${state.error}", style: const TextStyle(color: Colors.black)),
              );
            }
            if(state is PersonSuccessState){
              List<Person> personList = state.personList;
              print(personList.length);
              return personList.isNotEmpty
                  ? RefreshIndicator(
                onRefresh: () async{
                  context.read<PersonBloc>().add(LoadInitialListEvent());
                },
                child: ListView.builder(
                    controller: scrollController,
                    itemCount: personList.length + 1,
                    itemBuilder: (context, index) {
                      if(index < personList.length) {
                        return card(personList[index]);
                      } else if(state.pageIndex <= 4){
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else {
                        return const Padding(
                          padding: EdgeInsets.symmetric(vertical: 20.0),
                          child: Center(
                            child: Text("No More Data"),
                          ),
                        );
                      }
                    }),
              )
                  : const Center(
                child: Text("No Data Found"),
              );
            }
            return  const Center(
              child: Text("No Data Found"),
            );

          }),
    );
  }

  card(Person person){
    return Padding(
      padding: const EdgeInsets.symmetric(
          vertical: 4.0, horizontal: 8.0),
      child: Card(
        child: ListTile(
          title: Text(
              '${person.firstname} ${person.lastname}'),
          subtitle: Text(person.email!),
          leading: CircleAvatar(
            backgroundImage:
            NetworkImage(person.image.toString()),
          ),
          onTap: (){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => PersonDetailScreen(personDetails: person)),
            );
          },
        ),
      ),
    );
  }
}

