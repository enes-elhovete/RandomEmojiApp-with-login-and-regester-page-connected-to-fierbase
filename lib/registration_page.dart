import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController adressController = TextEditingController();
  final TextEditingController birthDateController = TextEditingController();
  final TextEditingController birthPlaceController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController surnameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> addUserToFirestore() async {

    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
    password: passwordController.text,
      );
// حفظ البيانات في Firestore
      await FirebaseFirestore.instance.collection('users').doc(userCredential.user!.uid).set({
        'name': nameController.text,
        'surname': surnameController.text,
        'email': emailController.text,
        'adress': adressController.text,
        'living-city': cityController.text,
        'birth-date': birthDateController.text,
        'birth-place': birthPlaceController.text,
        'password': passwordController.text,
      });
      print("User added to Firestore.");
    } catch (e) {
      print("Error adding user to Firestore: $e");
    }
    print("================================================================");
  }

  void _register() async {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Şifreler eşleşmiyor')),
        );
        return;
      }
      try {
        await addUserToFirestore();
        FirebaseAuth.instance.signOut();
       Navigator.pushReplacementNamed(context, '/');
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: ${e.message}')),
        );
      }
    }
  }

  Widget _buildField(String label, TextEditingController controller,
      {bool isPassword = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
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
      appBar: AppBar(title: const Text('Kayıt Ol')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 30),
                const Text(
                  'Register',
                  style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                _buildField('İsim', nameController),
                _buildField('Soyisim', surnameController),
                _buildField('E-posta', emailController),
                _buildField('Şifre', passwordController, isPassword: true),
                _buildField('Şifre Tekrar', confirmPasswordController, isPassword: true),
                _buildField('Adres', adressController),
                _buildField('Yaşadığı Şehir', cityController),
                _buildField('Doğum Tarihi', birthDateController),
                _buildField('Doğum Yeri', birthPlaceController),

                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _register,
                  child: const Text('Kayıt Ol', style: TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Hesabınız var mı?", style: TextStyle(fontSize: 16)),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, '/');
                      },
                      child: const Text(
                        ' Giriş yapınız',
                        style: TextStyle(fontSize: 18, color: Colors.blue),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
