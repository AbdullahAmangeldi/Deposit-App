import 'package:deposit_app/advise_widget.dart';
import 'package:deposit_app/createnewwallet.dart';
import 'package:deposit_app/deposits_page.dart';
import 'package:deposit_app/main_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'loginpage.dart';
class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            (selectedLanguage != 'ru') ? 'Username' :
            (selectedLanguage == 'kz') ? 'Пайдаланушы аты' : 'Имя пользователя',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 20),
          const CircleAvatar(
            minRadius: 50,
            child: Icon(Icons.person, size: 60),
          ),
          const SizedBox(height: 20),
          LinkPage(
            widget: const MainPage(),
            text: (selectedLanguage == 'ru') ? 'Мой бюджет' :
            (selectedLanguage == 'kz') ? 'Менің бюджетім' : 'My budget',
          ),
          const SizedBox(height: 10,),
          LinkPage(
            widget: NewWalletPage(typeOfWallet: 'wallet'),
            text: (selectedLanguage == 'ru') ? 'Новый кошелек' :
            (selectedLanguage == 'kz') ? 'Жаңа әмиян' : 'New wallet',
          ),
          const SizedBox(height: 10,),
          LinkPage(
            widget: NewWalletPage(typeOfWallet: 'rashod'),
            text: (selectedLanguage == 'ru') ? 'Новая категория' :
            (selectedLanguage == 'kz') ? 'Жаңа категория' : 'New category',
          ),
          const SizedBox(height: 10,),
          LinkPage(
            widget: NewWalletPage(typeOfWallet: 'deposit'),
            text: (selectedLanguage == 'ru') ? 'Новый депозит' :
            (selectedLanguage == 'kz') ? 'Жаңа депозит' : 'New deposit',
          ),
          const SizedBox(height: 10,),

          LinkPage(
            widget: const AdvisePage(),
            text: (selectedLanguage == 'ru') ? 'Финансовые советы' :
            (selectedLanguage == 'kz') ? 'Қаржылық ақыл кеңес' : 'Financial advice',
          ),
          const SizedBox(height: 20,),

          LinkPage(
            widget: const LoginPage(),
            text: (selectedLanguage == 'ru') ? 'Выйти' :
            (selectedLanguage == 'kz') ? 'Шығу' : 'Log out',
          ),

          // ElevatedButton(
          //     style: ElevatedButton.styleFrom(
          //
          //       padding: EdgeInsets.symmetric(vertical: 15),
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //     ),
          //     onPressed: () {
          //       if (selectedLanguage == 'ru') {
          //         selectedLanguage = 'en';
          //       } else {
          //         selectedLanguage = 'ru';
          //       }
          //       setState(() {
          //
          //       });
          //     },
          //     child: Text((selectedLanguage == 'ru') ? 'RU' : 'EN')),
          SizedBox(height: 20,),
          SegmentedButton(

            style: SegmentedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),

              )
            ),
              onSelectionChanged: (value) {
                setState(() {
                  selectedLanguage = value.elementAt(0);
                });
              },
              segments: const <ButtonSegment<String>> [

            ButtonSegment(value: 'kz', label: Text('Қазақ тілі')),
            ButtonSegment(value: 'ru', label: Text('Русский')),
            ButtonSegment(value: 'en',label: Text('English')),

          ], selected: {selectedLanguage})


        ],
      ),
    );
  }

  Widget _buildProfileItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
        ),
        textAlign: TextAlign.start,
      ),
    );
  }
}

class LinkPage extends StatefulWidget {
  const LinkPage({super.key, required this.widget, required this.text});

  final Widget widget;
  final String text;

  @override
  State<LinkPage> createState() => _LinkPageState();
}

class _LinkPageState extends State<LinkPage> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(builder: (context) {
          return widget.widget;
        }));
      },
      child: Text(widget.text,  style: const TextStyle(
        fontSize: 18,
      ),
        textAlign: TextAlign.start,),
    );
  }
}
