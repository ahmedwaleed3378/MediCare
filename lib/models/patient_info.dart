class Patient {
  final Person data;
  final Map<String, List<int>> bloodPress = {};
  final Map<String, String> bloodGlu = {};
  final Map<String, String> vaccines = {};
  final Map<String, String> allergy = {};
  final Map<String, String> medicalVisit = {};
  final Map<String, String> medicalAnalysis = {};

  Patient(this.data);

  void addPress(List<int> press, String date) {
    bloodPress[date] = press;
  }

  void deletePress(List<int> press, String date) {
    bloodPress.removeWhere((key, value) {
      if (key == date && value == press) {
        return true;
      }
      return false;
    });
  }

  void addGlu(String glu, String date) {
    bloodGlu[date] = glu;
  }

  void deleteGlu(String glu, String date) {
    bloodGlu.removeWhere((key, value) {
      if (key == date && value == glu) {
        return true;
      }
      return false;
    });
  }

  void addvaccines(String vac, String date) {
    vaccines[date] = vac;
  }

  void deletevaccines(String vac, String date) {
    vaccines.removeWhere((key, value) {
      if (key == date && value == vac) {
        return true;
      }
      return false;
    });
  }

  void addallergy(String aller, String date) {
    allergy[date] = aller;
  }

  void deleteallergy(String aller, String date) {
    allergy.removeWhere((key, value) {
      if (key == date && value == aller) {
        return true;
      }
      return false;
    });
  }
}

class Doctor {
  final Person data;
  final bool isPatient;
  Doctor(this.data, this.isPatient);
  void addPrescription(
      Patient patient, String diagnosis, String date, String note) {
    patient.medicalVisit['Doctor Name'] = this.data.name;
    patient.medicalVisit['Place'] = this.data.address;
    patient.medicalVisit['Diagnosis'] = diagnosis;
    patient.medicalVisit['Date'] = date;
    patient.medicalVisit['Notes'] = note;
  }
}

class Repository {
  List<Patient> patients = [];
  List<Doctor> doctors = [];
  Patient findPatient(String id) {
    return patients.firstWhere((patient) => patient.data.id == id);
  }

  Patient getLoggedPatient(String email) {
    return patients.firstWhere((element) => element.data.email == email);
  }

  Doctor getLoggedDoctor(String email) {
    return doctors.firstWhere((element) => element.data.email == email);
  }

  void getPatients() {}
  void getDoctors() {}
}

class Person {
  final String _name;
  final String _gender;
  final String _birthDate;
  final String _id;
  final String _email;
  final String _address;
  final String _phoneNum;
  final bool isPatient;
  Person(this._name, this._gender, this._birthDate, this._id, this._email,
      this._address, this._phoneNum, this.isPatient);

  String get name => _name;
  String get gender => _gender;
  String get birthDate => _birthDate;
  String get id => _id;
  String get email => _email;
  String get address => _address;
  String get phoneNum => _phoneNum;
}

class MedicalVisit {
  final String docname;
  final String place;
  final String drugs;
  final String diagnosis;
  final String date;
  final String note;
  final String docEmail;
  MedicalVisit({
    required this.docname,
    required this.place,
    required this.drugs,
    required this.diagnosis,
    required this.date,
    required this.note,
    required this.docEmail,
  });

  dynamic toJson() => {
        'docname': docname,
        'docEmail': docEmail,
        'place': place,
        'diagnosis': diagnosis,
        'date': date,
        'note': note,
        'drugs': drugs
      };

  factory MedicalVisit.fromJson(Map<String, dynamic> json) {
    return MedicalVisit(
        docname: json['docname'],
        docEmail: json['docEmail'],
        place: json['place'],
        diagnosis: json['diagnosis'],
        date: json['date'],
        note: json['note'],
        drugs: json['drugs']);
  }
}

class Allergies {
  String name;
  String date;
  Allergies({
    required this.name,
    required this.date,
  });

  dynamic toJson() => {
        'name': name,
        'date': date,
      };

  factory Allergies.fromJson(Map<String, dynamic> json) {
    return Allergies(
      name: json['name'],
      date: json['date'],
    );
  }
}

class Glucose {
  String glucoseRatio;
  String date;
  Glucose({
    required this.glucoseRatio,
    required this.date,
  });

  dynamic toJson() => {
        'ratio': glucoseRatio,
        'date': date,
      };

  factory Glucose.fromJson(Map<String, dynamic> json) {
    return Glucose(
      glucoseRatio: json['ratio'],
      date: json['date'],
    );
  }
}

class Vaccine {
  String vaccine;
  String date;
  Vaccine({
    required this.vaccine,
    required this.date,
  });

  dynamic toJson() => {
        'vaccine': vaccine,
        'date': date,
      };

  factory Vaccine.fromJson(Map<String, dynamic> json) {
    return Vaccine(
      vaccine: json['vaccine'],
      date: json['date'],
    );
  }
}

class BloodPresTofire {
  String sys;
  String dia;
  String pulMin;
  String date;
  BloodPresTofire({
    required this.sys,
    required this.dia,
    required this.pulMin,
    required this.date,
  });

  dynamic toJson() => {
        'sys': sys,
        'dia': dia,
        'pulMin': pulMin,
        'date': date,
      };

  factory BloodPresTofire.fromJson(Map<String, dynamic> json) {
    return BloodPresTofire(
      sys: json['sys'],
      dia: json['dia'],
      pulMin: json['pulMin'],
      date: json['date'],
    );
  }
}
