// Импортируем необходимые пакеты и страницы.
// 'deposits_page.dart' содержит код для страницы вкладов.
// 'history_page.dart' содержит код для страницы истории.
// 'loginpage.dart' содержит код для страницы входа.
// 'profile_page.dart' содержит код для страницы профиля.
// 'wallet_dialog.dart' содержит код для диалогового окна кошелька.
import 'package:deposit_app/deposits_page.dart';
import 'package:deposit_app/history_page.dart';
import 'package:deposit_app/loginpage.dart';
import 'package:deposit_app/profile_page.dart';
import 'package:deposit_app/wallet_dialog.dart';
import 'package:flutter/material.dart';

// Определение главного виджета приложения MainPage.
class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

// Состояние для виджета MainPage.
class _MainPageState extends State<MainPage> {
  // Индекс выбранной вкладки.
  int _selectedIndex = 0;

  // Стиль текста для заголовков.
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  // Список виджетов для отображения на различных вкладках.
  static final List<Widget> _widgetOptions = <Widget>[
    const DepositsPage(),
    const ProfilePage(),
    const HistoryPage(),
  ];

  // Списки заголовков для AppBar на разных языках.
  static final List<String> _appBarTitleOptions = <String>[
    'Главная',
    'Профиль',
    'История'
  ];

  static final List<String> _appBarTitleOptionsEN = <String>[
    'Main page',
    'Profile',
    'History'
  ];

  static final List<String> _appBarTitleOptionsKZ = <String>[
    'Басты бет',
    'Профиль',
    'Тарих'
  ];

  // Метод для обработки нажатия на элемент BottomNavigationBar.
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white.withOpacity(0.93),

      // Расположение плавающей кнопки.
      floatingActionButtonLocation:
      FloatingActionButtonLocation.miniCenterFloat,

      // Настройки AppBar.
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.lightGreen,
        // Заголовок AppBar в зависимости от выбранного языка.
        title: Text(
          (selectedLanguage == 'ru') ?
          _appBarTitleOptions.elementAt(_selectedIndex) :
          (selectedLanguage == 'kz') ?
          _appBarTitleOptionsKZ.elementAt(_selectedIndex) :
          _appBarTitleOptionsEN.elementAt(_selectedIndex),
        ),
      ),

      // Основное содержимое экрана.
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),

      // Нижняя навигационная панель.
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: (selectedLanguage == 'ru') ? 'Главная' :
            (selectedLanguage == 'en') ? 'Main page' :
            (selectedLanguage == 'kz') ? 'Басты бет' : '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: (selectedLanguage == 'ru') ? 'Профиль' :
            (selectedLanguage == 'en') ? 'Profile' :
            (selectedLanguage == 'kz') ? 'Профиль' : '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu),
            label: (selectedLanguage == 'ru') ? 'История' :
            (selectedLanguage == 'en') ? 'History' :
            (selectedLanguage == 'kz') ? 'Тарих' : '',
          ),
        ],
        currentIndex: _selectedIndex, // Текущий выбранный индекс.
        onTap: _onItemTapped, // Метод для обработки нажатия.
      ),
    );
  }
}
