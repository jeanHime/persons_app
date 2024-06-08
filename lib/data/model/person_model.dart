class Person {
  Person({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.phone,
    required this.birthday,
    required this.gender,
    required this.website,
    required this.image,
  });

  final String? firstname;
  final String? lastname;
  final String? email;
  final String? phone;
  final DateTime? birthday;
  final String? gender;
  final String? website;
  final String? image;

  Person copyWith({
    String? firstname,
    String? lastname,
    String? email,
    String? phone,
    DateTime? birthday,
    String? gender,
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
    "website": website,
    "image": image,
  };

}