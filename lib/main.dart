import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'login_page.dart';
import 'task_page.dart';
import 'task_list_page.dart';
import 'random_emojı.dart';
import 'hakkimizda_page.dart';
import 'kaydedilen_veriler.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      initialRoute: '/',
      routes: {
        '/': (context) => LoginPage(),
        '/task': (context) => TaskPage(),
        '/tasklist': (context) => TaskListPage(),
        '/randomEmo': (context) => RandomEmoPage(),
        '/hakkimizda': (context) => HakkimizdaPage(),
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
                  'Merhaba, ${_username ?? 'Guest'}',
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
