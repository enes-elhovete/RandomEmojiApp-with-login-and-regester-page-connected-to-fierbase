import 'dart:convert';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_auth_2/flutter_web_auth_2.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
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
  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null; // المستخدم لغى العملية

    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential> signInWithGitHub() async {
    const clientId = 'YOUR_GITHUB_CLIENT_ID';
    const clientSecret = 'YOUR_GITHUB_CLIENT_SECRET';
    const redirectUrl = 'https://<project-id>.firebaseapp.com/__/auth/handler';

    final result = await FlutterWebAuth2.authenticate(
      url: 'https://github.com/login/oauth/authorize?client_id=$clientId&redirect_uri=$redirectUrl&scope=read:user%20user:email',
      callbackUrlScheme: 'https',
    );

    final code = Uri.parse(result).queryParameters['code'];

    final response = await http.post(
      Uri.parse("https://github.com/login/oauth/access_token"),
      headers: {'Accept': 'application/json'},
      body: {
        'client_id': clientId,
        'client_secret': clientSecret,
        'code': code!,
      },
    );

    final accessToken = json.decode(response.body)['access_token'];

    final githubAuthCredential = GithubAuthProvider.credential(accessToken);
    return await FirebaseAuth.instance.signInWithCredential(githubAuthCredential);
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
              Expanded(child: Container(height: 2,color: Colors.black,)),
          Text("veya",style: TextStyle(fontSize: 16),),
              Expanded(child: Container(height: 2,color: Colors.black,)),
            ],),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                final user = await signInWithGoogle();
                if (user != null) {
                  Navigator.pushReplacementNamed(context, '/randomEmo');
                }
              },
              child: Text("Login with Google"),
            ),

            ElevatedButton(
              onPressed: () async {
                final user = await signInWithGitHub();
                if (user != null) {
                  Navigator.pushReplacementNamed(context, '/randomEmo');
                }
              },
              child: Text("Login with GitHub"),
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
