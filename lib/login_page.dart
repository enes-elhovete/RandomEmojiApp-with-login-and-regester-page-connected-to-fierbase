import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'random_emojı.dart';
import 'task_page.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> _saveCredentials(String name, String password) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('username', name);
    await prefs.setString('password', password);
  }

  void _login() async {
    final name = usernameController.text;
    final password = passwordController.text;
    if (name.isNotEmpty && password.isNotEmpty) {
      try {
        final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: name,
            password: password
        );
        await _saveCredentials(name, password);
        Navigator.pushReplacementNamed(context, '/randomEmo');
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
        }
      }

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Kullanıcı adı ve şifre giriniz')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Login')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 40),
            const Text(
              'Login',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 60),
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Kullanici Adı',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'şifre',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:_login,
              child: const Text('Giriş Yap', style: TextStyle(fontSize: 18)),
            ),
            const SizedBox(height: 16),
           Row(children: [
             Text("Hesabınız yok mu?",style: TextStyle(fontSize: 16),) ,
             InkWell(
               onTap: (){Navigator.pushReplacementNamed(context, '/register');},
               child: const Text('Kayıt olunuz',style: TextStyle(fontSize: 18,color: Colors.blue),),
             )],)

          ],
        ),
      ),
    );
  }
}
