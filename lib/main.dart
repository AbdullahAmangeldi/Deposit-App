// Импортируем необходимые пакеты.
// 'loginpage.dart' содержит код для страницы входа.
// 'material.dart' содержит основные компоненты UI Flutter.
// 'main_page.dart' содержит код для главной страницы.
import 'package:deposit_app/loginpage.dart';
import 'package:flutter/material.dart';
import 'main_page.dart';

// Главная точка входа в приложение.
void main() {
  // Запускаем приложение MyApp.
  runApp(const MyApp());
}

// Определение главного виджета приложения.
class MyApp extends StatelessWidget {
  // Конструктор для создания экземпляра MyApp.
  const MyApp({super.key});

  // Построение виджета приложения.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Отключение баннера отладки в углу экрана.
      debugShowCheckedModeBanner: false,
      // Установка начальной страницы приложения на LoginPage.
      home: LoginPage(),
    );
  }
}
