class Profile {
  static const NAME = 'name';
  static const SURNAME = 'surname';
  static const PHONE = 'phone';
  static const EMAIL = 'email';

  String? id;
  String? name;
  String? surname;
  String? phone;
  String? email;

  Profile({
    this.id,
    this.name,
    this.surname,
    this.phone,
    this.email,
  });

  //TODO: safe date extraction
  static fromMap(Map<String, dynamic>? data, String documentId) {
    return data == null
        ? null
        : Profile(
            id: documentId,
            name: data[NAME],
            surname: data[SURNAME],
            phone: data[PHONE],
            email: data[EMAIL],
          );
  }

  Map<String, dynamic> toMap() {
    return {
      NAME: name,
      SURNAME: surname,
      PHONE: phone,
      EMAIL: email,
    };
  }

  Profile copy({String? name, String? surname, String? phone, String? email}) {
    return Profile(
      id: this.id,
      name: (name == null || name == '') ? this.name : name,
      surname: (surname == null || surname == '') ? this.surname : surname,
      email: (email == null || email == '') ? this.email : email,
      phone: (phone == null || phone == '') ? this.phone : phone,
    );
  }

  //TODO: на форме собирать всю инфу!!!!
  static Profile createNew({
    String? id, //todo: needed?
    String? email,
    String? phone,
    String? name,
    String? surname,
  }) {
    return Profile(email: email, phone: phone, name: name, surname: surname);
  }
}
