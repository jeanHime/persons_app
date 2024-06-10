import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persons_app/bloc/person_event.dart';
import 'package:persons_app/bloc/person_state.dart';
import 'package:persons_app/data/model/person_model.dart';
import 'package:persons_app/data/repository/person_repository.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonRepository _personRepository;
  final List<Person> _fetchData = [];
  final List<Person> _displayData = [];
  int pageIndex = 1;

  PersonBloc(this._personRepository) : super(PersonInitialState()) {
    on<LoadInitialListEvent>((event, emit) async {
      /// clear list and reset page index to 1
      _fetchData.clear();
      _displayData.clear();
      pageIndex = 1;

      /// set state loading
      emit(PersonLoadingState());

      try {
        final persons = await _personRepository.getPersons();

        /// add all data got from api to fetch api
        /// add only 10 items to display item list
        _fetchData.addAll(persons);
        _displayData.addAll(
            _fetchData.getRange(_displayData.length, _displayData.length + 10));
        emit(PersonSuccessState(personList: _displayData, pageIndex: pageIndex));
      } catch (e) {
        emit(PersonErrorState(e.toString()));
      }
    });

    on<LoadMoreEvent>((event, emit) async {
      try {
        if (pageIndex > 4) return;

        /// when displayed data is still within fetch data, add data from fetch data
        if (_displayData.length < _fetchData.length) {
          _displayData.addAll(_fetchData.getRange(
              _displayData.length, _displayData.length + 10));
        } else {
          pageIndex++;

          final persons = await _personRepository.getPersons();

          /// add all data got from api to fetch api
          /// then add the new 10 items to display item list
          _fetchData.addAll(persons);
          _displayData.addAll(_fetchData.getRange(
              _displayData.length, _displayData.length + 10));
        }
        emit(PersonSuccessState(personList: _displayData, pageIndex: pageIndex));
      } catch (e) {
        emit(PersonErrorState(e.toString()));
      }
    });
  }
}
