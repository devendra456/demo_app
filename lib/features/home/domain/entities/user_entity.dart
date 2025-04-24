class UserEntity {
  final String gender;
  final Name name;
  final String email;
  final Dob dob;
  final String phone;
  final Picture picture;
  final String address;
  final String state;
  final String country;
  final String postcode;

  UserEntity({
    required this.gender,
    required this.name,
    required this.email,
    required this.dob,
    required this.phone,
    required this.picture,
    required this.address,
    required this.state,
    required this.country,
    required this.postcode,
  });

  String get fullName => '${name.first} ${name.last}';

  bool matchesSearch(String value) {
    return fullName.toLowerCase().contains(value.toLowerCase());
  }
}

class Dob {
  final DateTime date;
  final int age;

  Dob({required this.date, required this.age});
}

class Name {
  final String title;
  final String first;
  final String last;

  Name({required this.title, required this.first, required this.last});
}

class Picture {
  final String large;
  final String medium;
  final String thumbnail;

  Picture({required this.large, required this.medium, required this.thumbnail});
}
