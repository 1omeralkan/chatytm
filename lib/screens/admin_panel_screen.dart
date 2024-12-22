import 'package:flutter/material.dart';

class AdminPanelScreen extends StatefulWidget {
  @override
  _AdminPanelScreenState createState() => _AdminPanelScreenState();
}

class _AdminPanelScreenState extends State<AdminPanelScreen> {
  int _selectedIndex = 0;

  // Sayfa Listesi
  final List<Widget> _pages = [
    UserManagementPage(),
    RoleManagementPage(),
    ReportsPage(),
    SettingsPage(),
    LogoutPage(),
  ];

  void _handleLogout(BuildContext context) {
    // Çıkış işlemi ve yönlendirme
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sol Taraftaki Menü Çubuğu
          NavigationRail(
            selectedIndex: _selectedIndex,
            onDestinationSelected: (int index) {
              if (index == 4) {
                _handleLogout(
                    context); // Çıkış butonuna basıldığında işlem yapılır
              } else {
                setState(() {
                  _selectedIndex = index;
                });
              }
            },
            backgroundColor: Color(0xFF2C5364),
            unselectedIconTheme: IconThemeData(color: Colors.white70, size: 28),
            selectedIconTheme:
                IconThemeData(color: Colors.lightBlueAccent, size: 32),
            unselectedLabelTextStyle:
                TextStyle(color: Colors.white70, fontSize: 14),
            selectedLabelTextStyle:
                TextStyle(color: Colors.lightBlueAccent, fontSize: 16),
            labelType: NavigationRailLabelType.all,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.supervised_user_circle),
                selectedIcon: Icon(Icons.supervised_user_circle,
                    color: Colors.lightBlueAccent),
                label: Text('Kullanıcı Yönetimi'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.admin_panel_settings),
                selectedIcon: Icon(Icons.admin_panel_settings,
                    color: Colors.lightBlueAccent),
                label: Text('Rol Yönetimi'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.bar_chart),
                selectedIcon:
                    Icon(Icons.bar_chart, color: Colors.lightBlueAccent),
                label: Text('Raporlar'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                selectedIcon:
                    Icon(Icons.settings, color: Colors.lightBlueAccent),
                label: Text('Ayarlar'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.logout),
                selectedIcon: Icon(Icons.logout, color: Colors.redAccent),
                label: Text('Çıkış'),
              ),
            ],
          ),

          // Sağ Tarafta Sayfalar
          Expanded(
            child: Container(
              color: Colors.white,
              child: _pages[_selectedIndex],
            ),
          ),
        ],
      ),
    );
  }
}

// Kullanıcı Yönetimi Sayfası
class UserManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Kullanıcı Yönetimi Sayfası',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Rol Yönetimi Sayfası
class RoleManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Rol Yönetimi Sayfası',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Raporlar Sayfası
class ReportsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Raporlar Sayfası',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Ayarlar Sayfası
class SettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Ayarlar Sayfası',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}

// Çıkış Sayfası
class LogoutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Çıkış Yapılıyor...',
        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      ),
    );
  }
}
