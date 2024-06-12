
import 'package:deposit_app/main_page.dart';
import 'package:flutter/material.dart';

String selectedLanguage = 'ru';
bool isLogin = true;
Map<String, String> listOfUsers = {};

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController login = TextEditingController();
  TextEditingController password = TextEditingController();

  // Variable to store the selected language

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.green, Colors.greenAccent],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              (selectedLanguage == 'ru')
                  ? 'Добро пожаловать!'
                  : (selectedLanguage == 'kz')
                      ? 'Қош келдіңіз!'
                      : "Welcome!",
              style: TextStyle(
                color: Colors.white,
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30),
            TextFormField(
              controller: login,
              decoration: InputDecoration(
                hintText: (selectedLanguage != 'en') ? 'Логин' : 'Login',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                prefixIcon: Icon(Icons.email),
              ),
            ),
            SizedBox(height: 20),
            TextFormField(
              controller: password,
              decoration: InputDecoration(
                hintText: (selectedLanguage == 'ru')
                    ? 'Пароль'
                    : (selectedLanguage == 'kz')
                        ? 'Құпия сөз'
                        : 'Password',
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none,
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
                prefixIcon: Icon(Icons.lock),
              ),
              obscureText: true,
            ),
            SizedBox(height: 20),
            // DropdownButton to select language
            SegmentedButton(
                style: SegmentedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                )),
                onSelectionChanged: (value) {
                  setState(() {
                    selectedLanguage = value.elementAt(0);
                  });
                },
                segments: const <ButtonSegment<String>>[
                  ButtonSegment(value: 'kz', label: Text('Қазақ тілі')),
                  ButtonSegment(value: 'ru', label: Text('Русский')),
                  ButtonSegment(value: 'en', label: Text('English')),
                ],
                selected: {
                  selectedLanguage
                }),

            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                print(login.text);
                print( listOfUsers.keys.toList());
                if (password.text.trim() == 'user' &&
                    login.text.trim() == 'user' || listOfUsers.keys.toList().contains(login.text.trim()) && password.text.trim()  == listOfUsers[login.text.trim()] ) {
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return MainPage();
                  }));
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                (selectedLanguage == 'ru')
                    ? 'Войти'
                    : (selectedLanguage == 'kz' && isLogin)
                        ? 'Кіру'
                        : 'Log in',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                if (password.text.trim().isNotEmpty &&
                    login.text.trim().isNotEmpty) {
                  listOfUsers[login.text.trim()] =  password.text.trim();
                  print(listOfUsers);
                  print(listOfUsers.keys.toList());
                  Navigator.of(context)
                      .pushReplacement(MaterialPageRoute(builder: (context) {
                    return const MainPage();
                  }));
                }
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                (selectedLanguage == 'ru')
                    ? 'Зарегистрироваться'
                    : (selectedLanguage == 'kz' && isLogin)
                        ? 'Тіркелу'
                        : 'Register',
                style: TextStyle(
                  color: Colors.blue,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
