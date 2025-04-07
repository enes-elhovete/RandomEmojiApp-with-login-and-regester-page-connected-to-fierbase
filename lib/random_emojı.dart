import 'package:flutter/material.dart';
import 'dart:math';
import 'drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Emoji Randomizer',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF7C4DFF, {
          50: Color(0xFFE5D4FF),
          100: Color(0xFFCCAAFF),
          200: Color(0xFFB280FF),
          300: Color(0xFF9957FF),
          400: Color(0xFF7C4DFF),
          500: Color(0xFF5F43CC),
          600: Color(0xFF4936B3),
          700: Color(0xFF362A99),
          800: Color(0xFF241F7F),
          900: Color(0xFF120D66),
        }),
      ),
      home: RandomEmoPage(),
    );
  }
}

class RandomEmoPage extends StatefulWidget {
  @override
  _RandomEmoPageState createState() => _RandomEmoPageState();
}

class _RandomEmoPageState extends State<RandomEmoPage> {
  final List<String> emojis = [
    '😊',
    '😂',
    '😍',
    '🥺',
    '😎',
    '😜',
    '😢',
    '🤔',
    '😉',
    '😆',
    '😅',
    '😇',
    '😛',
    '😋',
    '😝',
    '😜',
    '🤗',
    '😐',
    '😶',
    '😏',
    '🙄',
    '😬',
    '😑',
    '🤐',
    '😷',
    '😓',
    '😥',
    '😨',
    '😰',
    '😱',
    '🤢',
    '🤮',
    '🤧',
    '😴',
    '🥱',
    '😪',
    '😵',
    '🤯',
    '😲',
    '😳',
    '🥴',
    '😈',
    '👿',
    '👻',
    '💀',
    '☠️',
    '👽',
    '👾',
    '🎃',
    '😺',
    '😸',
    '😻',
    '😼',
    '🙀',
    '😿',
    '😾',
    '🐶',
    '🐱',
    '🐭',
    '🐹',
    '🐰',
    '🐸',
    '🦊',
    '🐻',
    '🐼',
    '🐯',
    '🦁',
    '🐮',
    '🐷',
    '🐵',
    '🐧',
    '🐦',
    '🦉',
    '🦆',
    '🦅',
    '🦇',
    '🐢',
    '🐍',
    '🦎',
    '🐊',
    '🐳',
    '🐋',
    '🐬',
    '🐟',
    '🐠',
    '🐡',
    '🦑',
    '🦐',
    '🦞',
    '🦀',
    '🐙',
    '🦋',
    '🐌',
    '🐛',
    '🦗',
    '🦠',
    '🐜',
    '🐝',
    '🐞',
    '🦋',
    '🐞',
    '🌸',
    '🌼',
    '🌺',
    '🌻',
    '🌷',
    '🌹',
    '🥀',
    '🌺',
    '💐',
    '🌾',
    '🍀',
    '🍃',
    '🍂',
    '🍁',
    '🌰',
    '🌳',
    '🌴',
    '🌵',
    '🌲',
    '🌱',
  ];
  String currentEmoji = '😊';
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

  void getRandomEmoji() {
    final random = Random();
    setState(() {
      currentEmoji = emojis[random.nextInt(emojis.length)];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rastgele Emoji'),
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
            );
          },
        ),
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.blueAccent,
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Merhaba, ${_username ?? 'Misafir'}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text(
                    'Senin Rastgele Emoji:',
                    style: TextStyle(fontSize: 24),
                  ),
                  const SizedBox(height: 20),
                  Text(currentEmoji, style: const TextStyle(fontSize: 100)),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: getRandomEmoji,
                    child: const Text('Rastgele Emoji Göster'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
