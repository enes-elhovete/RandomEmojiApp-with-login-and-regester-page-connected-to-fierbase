import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserModel {
  final String name;
  final String surname;
  final String email;
  final String adress;
  final String city;
  final String birthDate;
  final String birthPlace;
  final String password;

  UserModel._internal({
    required this.name,
    required this.surname,
    required this.email,
    required this.adress,
    required this.city,
    required this.birthDate,
    required this.birthPlace,
    required this.password,
  });

  static UserModel? _instance;

  factory UserModel() {
    assert(_instance != null, 'You must call UserModel.load() before using the instance.');
    return _instance!;
  }

  static Future<void> load() async {
    try {
      print('Current UID: ${FirebaseAuth.instance.currentUser?.uid}');

      final user = FirebaseAuth.instance.currentUser;
      if (user == null) throw Exception('No user is logged in');

      final doc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();

      if (!doc.exists) throw Exception('User document not found');

      final data = doc.data()!;
      _instance = UserModel._internal(
        name: data['name'] ?? '',
        surname: data['surname'] ?? '',
        email: data['email'] ?? '',
        adress: data['adress'] ?? '',
        city: data['living-city'] ?? '',
        birthDate: data['birth-date'] ?? '',
        birthPlace: data['birth-place'] ?? '',
        password: data['password'] ?? '',
      );
    } catch (e) {
      print('حدث خطأ أثناء تحميل بيانات المستخدم: $e');
      _instance = null;
    }
  }
}
