import 'dart:convert';
import 'package:intl/intl.dart'; // Import DateFormat for date formatting
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'loginpage.dart';
class EditWalletDialog extends StatefulWidget {
  final Map<String, dynamic> walletData;

  final String typeOfWallet;



  EditWalletDialog({Key? key, required this.walletData, required this.typeOfWallet}) : super(key: key);

  @override
  _EditWalletDialogState createState() => _EditWalletDialogState();
}

class _EditWalletDialogState extends State<EditWalletDialog> {
  late TextEditingController _nameController;
  late TextEditingController _sumController;
  late TextEditingController _dateController = TextEditingController(text: "${DateTime.now().toLocal()}".split(' ')[0]);
  late int originalSum;
  DateTime selectedDate = DateTime.now();


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

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.walletData['name'] ?? '');
    _sumController = TextEditingController(text: widget.walletData['money']?.toString() ?? '');
    originalSum = widget.walletData['money'] ?? 0;
    _dateController =   TextEditingController(text: widget.walletData['date']?.toString() ?? "${DateTime.now().toLocal()}".split(' ')[0]);

  }


  void _showDeleteConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Удалить кошелек?'),
        content: Text('Уверены ли вы что хотите удалить этот кошелек?'),
        actions: [
          TextButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();
              Navigator.of(context).pop();
            },
            child: Text('Отменить'),
          ),
          TextButton(
            onPressed: () {
              _deleteWallet();
              Navigator.of(context).pop();
            },
            child: Text('Удалить кошелек'),
          ),
        ],
      ),
    );
  }
  void _deleteWallet() async {
    // Perform delete operation from Firebase
    final url = Uri.https(
      'wallletapp-22ffc-default-rtdb.firebaseio.com',
      'wallets/${widget.walletData['id']}.json',
    );
    final response = await http.delete(url);
    if (response.statusCode == 200) {
      // Handle success, maybe navigate to previous screen or show a success message
    } else {
      // Handle failure, maybe show an error message
    }
    FocusManager.instance.primaryFocus?.unfocus();
    Navigator.of(context).pop();
  }
  void sendTransaction(int difference) async {
    String formattedDate = DateFormat('dd.MM.yyyy').format(DateTime.now());
    final dataToSend = {
      'amount': difference,
      'date': formattedDate,
    };

    final url = Uri.https(
      'wallletapp-22ffc-default-rtdb.firebaseio.com',
      'transactions.json', // Adjust the path according to your database structure
    );

    final response = await http.post(
      url,
      body: json.encode(dataToSend),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      // Handle success
      print('Transaction sent successfully');
    } else {
      // Handle failure
      print(response.statusCode);
    }
  }

  Future<void> updateAdmissions(int difference) async {
    final url = Uri.https(
      'wallletapp-22ffc-default-rtdb.firebaseio.com',
      'admissions.json',
    );

    final admissionsData = await http.read(url);

    print(jsonDecode(admissionsData)['admissions']);

    final response = await http.put(
      url,
      body: json.encode({'admissions': difference +jsonDecode(admissionsData)['admissions'], 'minus':  jsonDecode(admissionsData)['minus'] }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update admissions');
    }
  }

  Future<void> updateMinus(int difference) async {
    final url = Uri.https(
      'wallletapp-22ffc-default-rtdb.firebaseio.com',
      'admissions.json',
    );

    final admissionsData = await http.read(url);

    print(jsonDecode(admissionsData)['minus']);

    final response = await http.put(
      url,
      body: json.encode({'minus': difference +jsonDecode(admissionsData)['minus'], 'admissions':  jsonDecode(admissionsData)['admissions']}),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update minus');
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _sumController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title:  Text(
          (selectedLanguage == 'ru')
              ? 'Изменить'
              : (selectedLanguage == 'kz')
              ? 'Өзгерту'
              : 'Edit',
        ),

        automaticallyImplyLeading: false,
        actions: [

            IconButton(
              onPressed: () {
                _showDeleteConfirmationDialog(context);
              },
              icon: Icon(Icons.delete),
            ),

          IconButton(
            onPressed: () {
              FocusManager.instance.primaryFocus?.unfocus();

              Navigator.of(context).pop();
            },
            icon: Icon(Icons.cancel_outlined),
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
                icon: Icon(
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
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey),
                        borderRadius: BorderRadius.circular(7),
                      ),

                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    (selectedLanguage == 'ru') ? 'Сумма на кошельке' :
                    (selectedLanguage == 'kz') ? 'Әмияндағы сома' : 'Amount of money',
                    style: TextStyle(fontSize: 18.0),
                    textAlign: TextAlign.left,
                  ),

                  SizedBox(height: 10),
                  TextField(
                    controller: _sumController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white70),
                        borderRadius: BorderRadius.circular(7),
                      ),
                      suffixText: (selectedLanguage != 'en') ? 'тг': 'tg',
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
                  (widget.typeOfWallet == 'deposit') ?   SizedBox(
                    height: 45,
                    child: TextField(
                      onTap: () async {
                        await _selectDate(context);
                        setState(() {

                        });
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
                  SizedBox(height: 20,)
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: TextButton(
               style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                // minimumSize: Size(300, 50),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    5,
                  ),
                ),
                elevation: 15.0,
              ),
                onPressed: () async {
                  int newSum = int.parse(_sumController.text);
                  if (newSum != originalSum) {
                    int difference = newSum - originalSum;
                    sendTransaction(difference);
                    if(newSum > originalSum) {
                      updateAdmissions(newSum - originalSum);
                    } else if (newSum < originalSum) {
                      updateMinus(difference);
                    }
                  }
                  FocusManager.instance.primaryFocus?.unfocus();
                  // Update wallet logic here
                  final dataToSend = {
                    'type': widget.walletData['type'],
                    'money': int.parse(_sumController.text),
                    'name': _nameController.text,
                  };


                  final url = Uri.https(
                    'wallletapp-22ffc-default-rtdb.firebaseio.com',
                    'wallets/${widget.walletData['id']}.json',
                  );
                  final response = await http.put(
                    url,
                    body: json.encode(dataToSend),
                    headers: {'Content-Type': 'application/json'},
                  );
                  print(response.statusCode);
                  FocusManager.instance.primaryFocus?.unfocus();


                  Navigator.of(context).pop();
                },
                child:Text(
                  (selectedLanguage == 'ru') ? 'Сохранить' :
                  (selectedLanguage == 'kz') ? 'Сақтау' : 'Save',
                  style: TextStyle(color: Colors.white),
                ),

              ),
            ),
          ],
        ),
      ),
    );
  }

}
