import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/bloc/person_event.dart';
import 'package:persons_app/bloc/person_state.dart';
import 'package:persons_app/data/model/person_model.dart';
import 'package:persons_app/data/repository/person_repository.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonRepository _personRepository;
  final List<Person> _fetchData = [];
  int pageIndex = 1;

  PersonBloc(this._personRepository) : super(PersonInitialState()) {
    on<LoadInitialListEvent>((event, emit) async {
      _fetchData.clear();
      emit(PersonLoadingState());

      try {
        final persons = await _personRepository.getPersons();
        _fetchData.addAll(persons);
        emit(PersonSuccessState(personList: _fetchData,pageIndex: pageIndex));
      } catch (e) {
        emit(PersonErrorState(e.toString()));
      }
    });

    on<LoadMoreEvent>((event, emit) async {
      try {
        pageIndex++;
        final persons = await _personRepository.getPersons();
        _fetchData.addAll(persons);
        emit(PersonSuccessState(personList: _fetchData,pageIndex: pageIndex));
      } catch (e) {
        emit(PersonErrorState(e.toString()));
      }
    });
  }
}
