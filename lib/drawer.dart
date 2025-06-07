import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'data_user.dart';
import 'random_emojı.dart';
import 'task_page.dart';
import 'task_list_page.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  String? _username;

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Misafir';
    });
  }

  @override
  void initState() {
    super.initState();
    _loadUsername();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Color(0xFF7C4DFF)),
            child: Center(
              child: Text(
                'Merhaba, ${UserModel().name ?? 'Misafir'}',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          ListTile(
            title: const Text('Rastgele emoji sayfası'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/randomEmo');
            },
          ),
          ListTile(
            title: const Text('Görev Ekle'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/task');
            },
          ),
          ListTile(
            title: const Text('Görev Listesi'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/tasklist');
            },
          ),
          ListTile(
            title: const Text('Kaydedilen Veriler'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/kaydedilenVeriler');
            },
          ),
          ListTile(
            title: const Text('Hakkımızda'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushNamed(context, '/hakkimizda');
            },
          ), ListTile(
            title: const Text('profile'),
            onTap: () {
              Navigator.pushReplacementNamed(context, "/profile");
            },
          ),
          ListTile(
            title: const Text('Çıkış Yap'),
            onTap: () async {
              final GoogleSignIn googleSignIn = GoogleSignIn();
              // تسجيل الخروج من Google
              await googleSignIn.signOut();
              FirebaseAuth.instance.signOut();
              Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
            },
          ),
        ],
      ),
    );
  }
}
