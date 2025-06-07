import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todayproject/data_user.dart';
import 'package:todayproject/profile_page.dart';
import 'package:todayproject/registration_page.dart';
import 'login_page.dart';
import 'task_page.dart';
import 'task_list_page.dart';
import 'random_emojı.dart';
import 'hakkimizda_page.dart';
import 'kaydedilen_veriler.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // إذا لم يتم التهيئة بعد، نقوم بها
  if (kIsWeb) {
    // التهيئة للويب
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyCPFVBs51AoZI624tQgJZcxpthpI34Skk8",
        authDomain: "hakan-e439d.firebaseapp.com",
        projectId: "hakan-e439d",
        storageBucket: "hakan-e439d.firebasestorage.app",
        messagingSenderId: "684240182376",
        appId: "1:684240182376:web:d5a3ed8db46b22a4a7afdd",
      ),
    );
  } else {
    // التهيئة للأندرويد أو iOS
    await Firebase.initializeApp();
  }
  runApp(MyApp());
}




class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Login',
      initialRoute: FirebaseAuth.instance.currentUser != null ? '/randomEmo' : '/',
      routes: {
        '/': (context) => LoginPage(),
        '/task': (context) => TaskPage(),
        '/tasklist': (context) => TaskListPage(),
        '/randomEmo': (context) => RandomEmoPage(),
        '/hakkimizda': (context) => HakkimizdaPage(),
        '/register': (context) => RegisterPage(),
        "/profile": (context) => ProfilePage(),
        '/kaydedilenVeriler':
            (context) => KaydedilenVerilerPage(), // إضافة الصفحة الجديدة
      },
    );
  }
}

class DrawerWidget extends StatefulWidget {

  @override
  _DrawerWidgetState createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  String? _username;

  Future<void> _loadUsername() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _username = prefs.getString('username') ?? 'Guest';
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
        children: [
          DrawerHeader(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Menu',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                Text(
                  'Merhaba, ${UserModel().name ?? 'Guest'}',
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Tasks'),
            onTap: () {
              Navigator.pushNamed(context, '/tasklist');
            },
          ),
          ListTile(
            title: const Text('Random Emoji'),
            onTap: () {
              Navigator.pushNamed(context, '/randomEmo');
            },
          ),
          ListTile(
            title: const Text('About Us'),
            onTap: () {
              Navigator.pushNamed(context, '/hakkimizda');
            },
          ),
        ],
      ),
    );
  }
}
