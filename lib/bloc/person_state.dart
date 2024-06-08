
import 'package:persons_app/data/model/person_model.dart';

sealed class PersonState{}

final class PersonInitialState extends PersonState{}

final class PersonLoadingState extends PersonState{}

final class PersonSuccessState extends PersonState{
  final List<Person> personList;
  final int pageIndex;

  PersonSuccessState({required this.personList,required this.pageIndex});
}

final class PersonErrorState extends PersonState{
  final String error;

  PersonErrorState(this.error);
}