import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _signOut(BuildContext context) {
    Navigator.pushReplacementNamed(context, '/login'); // Çıkış yap
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ana Sayfa'),
        centerTitle: true,
        backgroundColor: Color(0xFF2C5364),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Bildirimler Sayfası Açılacak')),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Profil Sayfası Açılacak')),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildCard(
              title: 'Mesajlar',
              subtitle: 'Sohbetlerinize göz atın',
              icon: Icons.message,
              onTap: () => Navigator.pushNamed(context, '/chat'),
            ),
            SizedBox(height: 16),
            _buildCard(
              title: 'Gruplar',
              subtitle: 'Grup sohbetlerinizi yönetin',
              icon: Icons.group,
              onTap: () => Navigator.pushNamed(context, '/groups'),
            ),
            SizedBox(height: 16),
            _buildCard(
              title: 'Ayarlar',
              subtitle: 'Hesap ve uygulama ayarlarını yapın',
              icon: Icons.settings,
              onTap: () => Navigator.pushNamed(context, '/settings'),
            ),
            SizedBox(height: 16),
            _buildCard(
              title: 'Profil',
              subtitle: 'Profil bilgilerinizi görüntüleyin',
              icon: Icons.account_circle,
              onTap: () => Navigator.pushNamed(context, '/profile'),
            ),
            SizedBox(height: 16),
            _buildCard(
              title: 'Çıkış Yap',
              subtitle: 'Hesabınızdan çıkış yapın',
              icon: Icons.logout,
              onTap: () => _signOut(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        leading: Icon(icon, size: 36, color: Color(0xFF2C5364)),
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(subtitle),
        trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFF2C5364)),
        onTap: onTap,
      ),
    );
  }
}
