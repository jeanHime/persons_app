class Person {
  Person({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.gender,
    required this.address,
    required this.website,
    required this.image,
  });

  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phone;
  final DateTime? birthday;
  final String? gender;
  final Address? address;
  final String? website;
  final String? image;

  Person copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    DateTime? birthday,
    String? gender,
    Address? address,
    String? website,
    String? image,
  }) {
    return Person(
      firstname: firstname ?? this.firstname,
      lastname: lastname ?? this.lastname,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      birthday: birthday ?? this.birthday,
      gender: gender ?? this.gender,
      address: address ?? this.address,
      website: website ?? this.website,
      image: image ?? this.image,
    );
  }

  factory Person.fromJson(Map<String, dynamic> json){
    return Person(
      firstname: json["firstname"],
      lastname: json["lastname"],
      email: json["email"],
      phone: json["phone"],
      birthday: DateTime.tryParse(json["birthday"] ?? ""),
      gender: json["gender"],
      address: json["address"] == null ? null : Address.fromJson(json["address"]),
      website: json["website"],
      image: json["image"],
    );
  }

  Map<String, dynamic> toJson() => {
    "firstname": firstname,
    "lastname": lastname,
    "email": email,
    "phone": phone,
    "birthday": "${birthday!.year.toString().padLeft(4,'0')}-${birthday!.month.toString().padLeft(2,'0')}-${birthday!.day.toString().padLeft(2,'0')}",
    "gender": gender,
    "address": address?.toJson(),
    "website": website,
    "image": image,
  };

}

class Address {
  Address({
    required this.id,
    required this.street,
    required this.streetName,
    required this.buildingNumber,
    required this.city,
    required this.zipcode,
    required this.country,
    required this.countyCode,
    required this.latitude,
    required this.longitude,
  });

  final int? id;
  final String? street;
  final String? streetName;
  final String? buildingNumber;
  final String? city;
  final String? zipcode;
  final String? country;
  final String? countyCode;
  final double? latitude;
  final double? longitude;

  Address copyWith({
    int? id,
    String? street,
    String? streetName,
    String? buildingNumber,
    String? city,
    String? zipcode,
    String? country,
    String? countyCode,
    double? latitude,
    double? longitude,
  }) {
    return Address(
      id: id ?? this.id,
      street: street ?? this.street,
      streetName: streetName ?? this.streetName,
      buildingNumber: buildingNumber ?? this.buildingNumber,
      city: city ?? this.city,
      zipcode: zipcode ?? this.zipcode,
      country: country ?? this.country,
      countyCode: countyCode ?? this.countyCode,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
    );
  }

  factory Address.fromJson(Map<String, dynamic> json){
    return Address(
      id: json["id"],
      street: json["street"],
      streetName: json["streetName"],
      buildingNumber: json["buildingNumber"],
      city: json["city"],
      zipcode: json["zipcode"],
      country: json["country"],
      countyCode: json["county_code"],
      latitude: json["latitude"],
      longitude: json["longitude"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
    "street": street,
    "streetName": streetName,
    "buildingNumber": buildingNumber,
    "city": city,
    "zipcode": zipcode,
    "country": country,
    "county_code": countyCode,
    "latitude": latitude,
    "longitude": longitude,
  };

}
