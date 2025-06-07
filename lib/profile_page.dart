import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'data_user.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController adressController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();





  Future<void> createOrUpdateUserDocument({
    required String name,
    required String surname,
    required String adress,
    required String city,
    required String birthDate,
    required String birthPlace,
    required String password,
    required String email,
  }) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) throw Exception('No user is logged in');

    final userDocRef = FirebaseFirestore.instance.collection('users').doc(user.uid);

    final docSnapshot = await userDocRef.get();

    if (docSnapshot.exists) {
      // ✅ التحديث
      await userDocRef.update({
        'name': name,
        'surname': surname,
        'adress': adress,
        'living-city': city,
        'birth-date': birthDate,
        'birth-place': birthPlace,
        // يمكن تحديث الإيميل من Firebase Auth أيضاً
        'email':  user.email,
        'password': password, // يمكن تركه فارغًا للمستخدمين الذين دخلوا عبر Google/GitHub
      });
    } else {
      // ✅ الإنشاء
      await userDocRef.set({
        'name': name,
        'surname': surname,
        'adress': adress,
        'living-city': city,
        'birth-date': birthDate,
        'birth-place': birthPlace,
        'email': user.email,
        'password': password, // يمكن تركه فارغًا للمستخدمين الذين دخلوا عبر Google/GitHub
      });
    }
  }


  @override
  void initState() {
    super.initState();
    adressController.text = UserModel().adress;
    birthDateController.text = UserModel().birthDate;
    birthPlaceController.text = UserModel().birthPlace;
    emailController.text = UserModel().email;
    cityController.text = UserModel().city;
    nameController.text = UserModel().name;
    surnameController.text = UserModel().surname;
    passwordController.text = UserModel().password;

  }

  Widget _buildField(String label, TextEditingController controller,
      {bool isPassword = false, bool readOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        readOnly: readOnly,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (!readOnly && (value == null || value.trim().isEmpty)) {
            return '$label alanı boş bırakılamaz';
          }
          return null;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profil Sayfası')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Profil Bilgileri',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                _buildField('İsim', nameController),
                _buildField('Soyisim', surnameController),
                _buildField('E-posta', emailController, readOnly: true),
                _buildField('Şifre', passwordController, isPassword: true, readOnly: true),
                _buildField('Adres', adressController),
                _buildField('Yaşadığı Şehir', cityController),
                _buildField('Doğum Tarihi', birthDateController),
                _buildField('Doğum Yeri', birthPlaceController),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      createOrUpdateUserDocument(
                        name: nameController.text,
                        surname: surnameController.text,
                        adress: adressController.text,
                        city: cityController.text,
                        birthDate: birthDateController.text,
                        birthPlace: birthPlaceController.text,
                        password: passwordController.text,
                        email: emailController.text,
                      );
                    }
                    UserModel.load();
                  },
                  child: const Text('Güncelle', style: TextStyle(fontSize: 18)),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
