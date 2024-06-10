import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:persons_app/data/model/person_model.dart';

class PersonDetailScreen extends StatelessWidget {
  final Person personDetails;
  const PersonDetailScreen({super.key, required this.personDetails});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("PersonsList"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: [
            Center(
              child: SizedBox(
                width: 100,
                height: 100,
                child: CircleAvatar(
                  backgroundImage: NetworkImage(personDetails.image.toString()),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Center(
                child: Text('${personDetails.firstname} ${personDetails.lastname}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            _detailItem("Email",personDetails.email!),
            const SizedBox(height: 8,),
            _detailItem("Phone",personDetails.phone!),
            const SizedBox(height: 8,),
            _detailItem("Birthday",DateFormat.yMMMMd().format(personDetails.birthday!)),
            const SizedBox(height: 8,),
            _detailItem("Gender",personDetails.gender!),
            const SizedBox(height: 8,),
            _detailItem("Website",personDetails.website!),
            const SizedBox(height: 8,),
            _detailItem("Address",'${personDetails.address!.street!} ${personDetails.address!.streetName!} ${personDetails.address!.buildingNumber!} ${personDetails.address!.city!} ${personDetails.address!.zipcode!} ${personDetails.address!.country!} ${personDetails.address!.countyCode!}'),
          ],
        ),
      ),
    );
  }
  _detailItem(String itemName, String itemDetail){
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          flex: 1,
          child: Text(itemName,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          flex: 4,
          child: Text(itemDetail),
        ),
      ],
    );
  }
}
