import 'package:flutter/material.dart';
import 'package:petmatch/telas/tela_inicial.dart'; // Adjust paths according to your project structure
import 'package:petmatch/telas/tela_denuncias.dart';
import 'package:petmatch/telas/tela_config.dart';

class NavBarPage extends StatefulWidget {
  final String initialPage;

  const NavBarPage({super.key, this.initialPage = 'home'});

  @override
  _NavBarPageState createState() => _NavBarPageState();
}

class _NavBarPageState extends State<NavBarPage> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const TelaInicialWidget(),
    const TelaDenunciasWidget(),
    const TelaConfigWidget(),
  ];

  @override
  void initState() {
    super.initState();
    // Set initial page based on the argument
    if (widget.initialPage == 'Início') {
      _currentIndex = 0;
    } else if (widget.initialPage == 'Denúncias') {
      _currentIndex = 1;
    } else if (widget.initialPage == 'Configurações') {
      _currentIndex = 2;
    }
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        selectedItemColor: Colors.white, // Set selected item color to orange
        unselectedItemColor: Colors.white, // Set unselected item color
        backgroundColor: const Color(
            0xFFF4A905), // Set background color of the BottomNavigationBar
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Início',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Denúncias',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Configurações',
          ),
        ],
      ),
    );
  }
}
