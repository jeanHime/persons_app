

import 'package:dio/dio.dart';

import '../model/person_model.dart';

class PersonProvider{
  final Dio _dio = Dio(BaseOptions(baseUrl: "https://fakerapi.it/"));

  Future<List<Person>> getPersonsList() async{
    try{
      final response = await _dio.get("/api/v1/persons?_quantity=20");
      List<Map<String,dynamic>> data = (response.data["data"] as List).map((e) => e as Map<String,dynamic>).toList();
      List<Person> persons = [];
      for (Map<String,dynamic> datum in data) {
        persons.add(Person.fromJson(datum));
      }
      return persons;
    }catch(e){
      return Future.error(e.toString());
    }
  }
}