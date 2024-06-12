import 'package:flutter/material.dart';

import 'loginpage.dart';

class ChooseTime extends StatefulWidget {
  const ChooseTime({super.key});

  @override
  State<ChooseTime> createState() => _ChooseTimeState();
}

class _ChooseTimeState extends State<ChooseTime> {
  int? _selectedValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          (selectedLanguage == 'ru')
              ? 'Выписка'
              : (selectedLanguage == 'kz')
                  ? 'Көшірме'
                  : 'Extract',
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: <Widget>[
            _buildRadioButton(
              1,
              (selectedLanguage == 'ru')
                  ? 'Неделя'
                  : (selectedLanguage == 'kz')
                      ? 'Бір апта'
                      : 'One week',
            ),
            _buildRadioButton(
              2,
              (selectedLanguage == 'ru')
                  ? 'Месяц'
                  : (selectedLanguage == 'kz')
                      ? 'Бір ай'
                      : 'One month',
            ),
            _buildRadioButton(
              3,
              (selectedLanguage == 'ru')
                  ? 'Три месяца'
                  : (selectedLanguage == 'kz')
                      ? 'Үш ай'
                      : 'Three months',
            ),
            _buildRadioButton(
              4,
              (selectedLanguage == 'ru')
                  ? 'Полгода'
                  : (selectedLanguage == 'kz')
                      ? 'Жарты жыл'
                      : 'Half-year',
            ),
            _buildRadioButton(
              5,
              (selectedLanguage == 'ru')
                  ? 'Один год'
                  : (selectedLanguage == 'kz')
                      ? 'Бір жыл'
                      : 'One year',
            ),
            _buildRadioButton(
              6,
              (selectedLanguage == 'ru')
                  ? 'Выбрать период'
                  : (selectedLanguage == 'kz')
                      ? 'Уақыт аралығын таңдау'
                      : 'Choose a time period',
            ),
            SizedBox(
              height: 30,
            ),
            ElevatedButton(

                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text(
                  (selectedLanguage == 'ru')
                      ? 'Использовать'
                      : (selectedLanguage == 'kz')
                          ? 'Қолдану'
                          : 'Apply',
                ))
          ],
        ),
      ),
    );
  }

  Widget _buildRadioButton(int value, String text) {
    return Row(
      children: <Widget>[
        Text(
          text,
          style: TextStyle(fontSize: 20),
        ),
        Spacer(),
        Radio<int>(
          value: value,
          groupValue: _selectedValue,
          onChanged: (int? newValue) {
            setState(() {
              _selectedValue = newValue;
            });
          },
        ),
      ],
    );
  }
}
