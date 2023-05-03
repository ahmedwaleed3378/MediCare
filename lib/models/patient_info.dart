class Patient {
  final Map<String, List<int>> bloodPress = {};
  final Map<String, int> bloodGlu = {};
  final Map<String, String> vaccines = {};
  final Map<String, String> allergy = {};
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
  void addGlu(int glu, String date) {
    bloodGlu[date] = glu;
  }

  void deleteGlu(int glu, String date) {
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

class Person {
  final String _name;
  final String _gender;
  final String _birthDate;
  final String _id;
  final String _email;
  final String _address;
  final String _phoneNum;

  Person(this._name, this._gender, this._birthDate, this._id, this._email,
      this._address, this._phoneNum);

  String get name => _name;
  String get gender => _gender;
  String get birthDate => _birthDate;
  String get id => _id;
  String get email => _email;
  String get address => _address;
  String get phoneNum => _phoneNum;
}
