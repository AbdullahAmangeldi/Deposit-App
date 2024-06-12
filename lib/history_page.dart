import 'dart:convert';

import 'package:deposit_app/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'choose_time.dart';
import 'loginpage.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({super.key});

  @override
  State<HistoryPage> createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  @override
  void initState() {
    super.initState();
    fetchTransactions();
  }
  bool sortByNew = true;

  int admissions = 0;
  int minus = 0;

  List transactions = [];

  Future<void> fetchTransactions() async {
    final url = Uri.https(
      'wallletapp-22ffc-default-rtdb.firebaseio.com',
      'transactions.json',
    );

    final url2 = Uri.https(
      'wallletapp-22ffc-default-rtdb.firebaseio.com',
      'admissions.json',
    );

    final admissionsData = await http.read(url2);
    //
    setState(() {
      admissions = jsonDecode(admissionsData)['admissions'];
      minus = jsonDecode(admissionsData)['minus'];
    });

    final response = await http.get(url);
    if (response.statusCode == 200) {
      final Map<String, dynamic>? data = json.decode(response.body);
      if (data != null) {
        List<Map<String, dynamic>> tempList = [];
        data.forEach((key, value) {
          tempList.add(value);
        });
        setState(() {
          transactions = tempList;
        });
      }
    } else {
      throw Exception('Failed to load transactions');
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            _buildProfileItem(
              (selectedLanguage == 'ru')
                  ? 'За весь период'
                  : (selectedLanguage == 'kz')
                      ? 'Барлық уақыт үшін'
                      : 'For the whole period',
            ),

            // Image.asset((selectedLanguage == 'ru')
            //     ? 'images/ru.png'
            //     : (selectedLanguage == 'kz')
            //         ? 'images/kz.png'
            //         : 'images/en.png'),
            Text(
              (admissions - (-1 * minus)).toString(),
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
            ),
            const SizedBox(
              height: 10,
            ),
            LinkPage(
              widget: const ChooseTime(),
              text: (selectedLanguage == 'ru')
                  ? 'Выписка'
                  : (selectedLanguage == 'kz')
                      ? 'Көшірме'
                      : 'Extract',
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Material(
                      child: Card(
                        child: SizedBox(
                          height: 100,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (selectedLanguage == 'ru')
                                    ? 'Поступления'
                                    : (selectedLanguage == 'kz')
                                        ? 'Кірістер'
                                        : 'Admissions',
                              ),
                              Text(
                                admissions.toString(),
                                style: TextStyle(color: Colors.green),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Material(
                      child: Card(
                        child: SizedBox(
                          height: 100,
                          width: 150,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                (selectedLanguage == 'ru')
                                    ? 'Списывания'
                                    : (selectedLanguage == 'kz')
                                        ? 'Шығындар'
                                        : 'Expenses',
                              ),
                              Text(
                                minus.toString(),
                                style: TextStyle(color: Colors.red),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  sortByNew = !sortByNew;
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    (selectedLanguage == 'ru')
                        ? 'Список операций'
                        : (selectedLanguage == 'kz')
                            ? 'Операциялар тізімі'
                            : 'Transactions history',
                    textAlign: TextAlign.left,
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.sort)
                ],
              ),
            ),
            Expanded(
              child: transactions.isNotEmpty
                  ? ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        List reversedTransactions =
                            List.from(transactions.reversed);
                        final transaction = (sortByNew) ? reversedTransactions[index] : transactions[index];
                        return ListTile(
                          leading: Text(
                            transaction['date'] ?? '',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          trailing: Text(
                            '${transaction['amount']}тг' ?? '',
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    )
                  : Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ],
        ),
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
