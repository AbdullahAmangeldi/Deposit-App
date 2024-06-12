// Импортируем необходимые пакеты и страницы.
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'deposits_page.dart';
import 'loginpage.dart';

// Определение виджета страницы создания нового кошелька.
class NewWalletPage extends StatefulWidget {
  NewWalletPage({
    super.key,
    required this.typeOfWallet,
  });

  @override
  _NewWalletPageState createState() => _NewWalletPageState();
  final String typeOfWallet; // Тип кошелька (кошелек, депозит, расход).
}

// Состояние для виджета NewWalletPage.
class _NewWalletPageState extends State<NewWalletPage> {
  DateTime selectedDate = DateTime.now(); // Выбранная дата.

  // Метод для выбора даты через диалоговое окно.
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != selectedDate) {
      setState(() async {
        _dateController.text = "${picked.toLocal()}".split(' ')[0];
        selectedDate = picked;
      });
    }
  }

  // Контроллеры для текстовых полей.
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sumController = TextEditingController();
  final TextEditingController _dateController = TextEditingController(text: "${DateTime.now().toLocal()}".split(' ')[0]);

  // Метод для обновления данных о поступлениях.
  Future<void> updateAdmissions(int difference) async {
    final url = Uri.https(
      'wallletapp-22ffc-default-rtdb.firebaseio.com',
      'admissions.json',
    );

    final admissionsData = await http.read(url);

    print(jsonDecode(admissionsData)['admissions']);

    final response = await http.put(
      url,
      body: json.encode({'admissions': difference + jsonDecode(admissionsData)['admissions'], 'minus': jsonDecode(admissionsData)['minus']}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update admissions');
    }
  }

  // Метод для отправки транзакции на сервер.
  Future<void> sendTransaction(int difference) async {
    String formattedDate = DateFormat('dd.MM.yyyy').format(DateTime.now());
    final dataToSend = {
      'amount': difference,
      'date': formattedDate,
    };

    final url = Uri.https(
      'wallletapp-22ffc-default-rtdb.firebaseio.com',
      'transactions.json', // Укажите путь в соответствии со структурой вашей базы данных.
    );

    final response = await http.post(
      url,
      body: json.encode(dataToSend),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Обработка успешной отправки.
      print('Transaction sent successfully');
    } else {
      // Обработка ошибки.
      print(response.statusCode);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        toolbarHeight: 120,
        centerTitle: true,
        title: Text(
          (widget.typeOfWallet == 'wallet' && selectedLanguage == 'ru')
              ? 'Новый кошелек'
              : (widget.typeOfWallet == 'deposit' && selectedLanguage == 'ru')
              ? 'Новый депозит'
              : (widget.typeOfWallet == 'rashod' && selectedLanguage == 'ru')
              ? 'Новая категория'
              : (widget.typeOfWallet == 'wallet' && selectedLanguage == 'en')
              ? 'New wallet'
              : (widget.typeOfWallet == 'deposit' && selectedLanguage == 'en')
              ? 'New deposit'
              : (widget.typeOfWallet == 'rashod' && selectedLanguage == 'en')
              ? 'New category'
              : (widget.typeOfWallet == 'wallet' && selectedLanguage == 'kz')
              ? 'Жаңа әмиян'
              : (widget.typeOfWallet == 'deposit' && selectedLanguage == 'kz')
              ? 'Жаңа депозит'
              : (widget.typeOfWallet == 'rashod' && selectedLanguage == 'kz')
              ? 'Жаңа категория'
              : '',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        automaticallyImplyLeading: false,
        actions: [
          SizedBox(
            width: 50,
            child: InkWell(
              splashColor: Colors.white,
              onTap: () {
                Navigator.of(context).pop(); // Возвращаемся на предыдущую страницу.
              },
              child: const Icon(
                Icons.cancel_outlined,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: Colors.yellow,
              child: IconButton(
                icon: const Icon(
                  Icons.monetization_on_outlined,
                  weight: 0.5,
                  size: 40,
                ),
                onPressed: () {},
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (selectedLanguage == 'ru') ? 'Название' :
                    (selectedLanguage == 'kz') ? 'Атауы' : 'Name',
                    style: TextStyle(
                      fontSize: 18.0,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 45,
                    child: TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    (selectedLanguage == 'ru')
                        ? 'Сумма на кошельке'
                        : (selectedLanguage == 'kz')
                        ? 'Әмияндағы сома'
                        : 'Amount of money',
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.left,
                  ),
                  SizedBox(height: 10),
                  SizedBox(
                    height: 45,
                    child: TextField(
                      controller: _sumController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.white70,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                        suffixText: (selectedLanguage == 'ru') ? 'тг': 'tg',
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  (widget.typeOfWallet == 'deposit') ? Text(
                    (selectedLanguage == 'ru')
                        ? 'Дата напоминания'
                        : (selectedLanguage == 'kz')
                        ? 'Еске салу күні'
                        : 'Reminder Date',
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.left,
                  ) : SizedBox(),
                  (widget.typeOfWallet == 'deposit') ? SizedBox(
                    height: 45,
                    child: TextField(
                      onTap: () async {
                        await _selectDate(context);
                        setState(() {});
                      },
                      readOnly: true,
                      controller: _dateController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey,
                          ),
                          borderRadius: BorderRadius.circular(7),
                        ),
                      ),
                    ),
                  ) : SizedBox(),
                  SizedBox(height: 20),
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  elevation: 15.0,
                ),
                onPressed: () async {
                  // Обработка введенных данных.
                  FocusManager.instance.primaryFocus?.unfocus();

                  final dataToSend = {
                    'type': widget.typeOfWallet,
                    'money': int.parse(_sumController.text),
                    'name': _nameController.text,
                    'date': _dateController.text
                  };

                  final url = Uri.https(
                      'wallletapp-22ffc-default-rtdb.firebaseio.com',
                      'wallets.json');
                  final response = await http.post(url,
                      body: json.encode(dataToSend),
                      headers: {'Content-Type': 'application/json'});
                  print(response.statusCode);
                  walletsList = await loadItems();
                  await updateAdmissions(int.parse(_sumController.text));
                  await sendTransaction(int.parse(_sumController.text));
                  setState(() {});
                  Navigator.of(context).pop();
                  // Дополнительно можно выполнить действия по сохранению данных в базе данных.
                },
                child: Text(
                  (selectedLanguage == 'ru') ? 'Создать' :
                  (selectedLanguage == 'kz') ? 'Құру' : 'Create',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sumController.dispose();
    super.dispose();
  }
}
