import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'screens/admin_panel_screen.dart';
import 'screens/home_screen.dart'; // HomeScreen sınıfını içe aktarıyoruz
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'screens/chat_screen.dart'; // ChatPage sınıfını içe aktarıyoruz

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(); // Firebase'i başlatıyoruz
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/login', // Uygulama başlatıldığında açılacak sayfa
      routes: {
        '/login': (context) => LoginScreen(), // Login Sayfası
        '/register': (context) => RegisterScreen(), // Kayıt Sayfası
        '/home': (context) => HomeScreen(), // Ana Sayfa
        '/adminPanel': (context) => AdminPanelScreen(), // Admin Paneli
        '/chat': (context) => ChatScreen(), // Chat ekranı
        '/userManagement': (context) =>
            PlaceholderScreen(title: 'Kullanıcı Yönetimi'),
        '/roleManagement': (context) =>
            PlaceholderScreen(title: 'Rol Yönetimi'),
        '/reports': (context) => PlaceholderScreen(title: 'Raporlar'),
        '/settings': (context) => PlaceholderScreen(title: 'Ayarlar'),
        '/profile': (context) => PlaceholderScreen(title: 'Profil'),
      },
      theme: ThemeData(
        primaryColor: Color(0xFF2C5364),
        scaffoldBackgroundColor: Colors.white,
      ),
    );
  }
}

class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: Color(0xFF2C5364),
      ),
      body: Center(
        child: Text(
          '$title Sayfası',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
