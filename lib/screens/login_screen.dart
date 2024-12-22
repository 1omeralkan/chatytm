import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class LoginScreen extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final DatabaseReference _database =
      FirebaseDatabase.instance.ref().child('users');

  Future<void> _loginUser(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        final DataSnapshot snapshot =
            await _database.child(userCredential.user!.uid).get();

        if (snapshot.exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content:
                  Text('Giriş Başarılı, Hoşgeldin ${_emailController.text}!'),
            ),
          );
          Navigator.pushNamed(context, '/home');
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text('Veritabanında kullanıcı bilgisi bulunamadı')),
          );
        }
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Giriş Hatası: ${e.message}')),
        );
      }
    }
  }

  Future<void> _resetPassword(BuildContext context) async {
    if (_emailController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Lütfen e-posta adresinizi giriniz.')),
      );
      return;
    }

    try {
      await _auth.sendPasswordResetEmail(email: _emailController.text.trim());
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Şifre sıfırlama bağlantısı gönderildi.')),
      );
    } on FirebaseAuthException catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Hata: ${e.message}')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF7F7F7), // Ferah bir açık gri arka plan
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Card(
              color: Colors.white,
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Logo veya İkon
                      Container(
                        decoration: BoxDecoration(
                          color:
                              Color(0xFFD1E8E2), // Hafif mint yeşili arkaplan
                          shape: BoxShape.circle,
                        ),
                        padding: EdgeInsets.all(20),
                        child: Icon(Icons.lock,
                            color: Color(0xFF4D8076), size: 50),
                      ),
                      SizedBox(height: 20),

                      // Başlık
                      Text(
                        'Giriş Yap',
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF4D8076), // Hafif koyu yeşil ton
                        ),
                      ),
                      SizedBox(height: 20),

                      // E-posta Alanı
                      TextFormField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEFF8F7), // Çok hafif açık yeşil
                          labelText: 'E-posta',
                          labelStyle: TextStyle(color: Colors.black54),
                          prefixIcon:
                              Icon(Icons.email, color: Color(0xFF4D8076)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'E-posta alanı boş olamaz' : null,
                      ),
                      SizedBox(height: 16),

                      // Şifre Alanı
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Color(0xFFEFF8F7),
                          labelText: 'Şifre',
                          labelStyle: TextStyle(color: Colors.black54),
                          prefixIcon:
                              Icon(Icons.lock, color: Color(0xFF4D8076)),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Şifre alanı boş olamaz' : null,
                      ),
                      SizedBox(height: 20),

                      // Giriş Yap Butonu
                      ElevatedButton(
                        onPressed: () => _loginUser(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFF4D8076),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.symmetric(
                              horizontal: 50, vertical: 15),
                        ),
                        child: Text(
                          'Giriş Yap',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                      SizedBox(height: 10),

                      // Şifremi Unuttum
                      TextButton(
                        onPressed: () => _resetPassword(context),
                        child: Text(
                          'Şifremi Unuttum',
                          style: TextStyle(
                            color: Color(0xFF4D8076),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      // Kayıt Ol Butonu
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/register');
                        },
                        child: Text(
                          'Hesabınız yok mu? Kayıt Ol',
                          style: TextStyle(
                            color: Color(0xFF4D8076),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
