import 'package:persons_app/data/model/person_model.dart';
import 'package:persons_app/data/provider/prerson_provider.dart';

abstract class IPersonRepository {
  Future<List<Person>> getPersons();
}

class PersonRepository implements IPersonRepository{
  final PersonProvider personProvider;

  PersonRepository(this.personProvider);

  @override
  Future<List<Person>> getPersons() {
    return personProvider.getPersonsList();
  }


}