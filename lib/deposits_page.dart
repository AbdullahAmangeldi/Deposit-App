import 'dart:convert';

import 'package:deposit_app/createnewwallet.dart';
import 'package:deposit_app/loginpage.dart';
import 'package:deposit_app/money_icon.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uuid/uuid.dart';

import 'editwallet.dart';

// Глобальный список кошельков.
List walletsList = [];

// Функция для загрузки данных о кошельках из Firebase.
Future<List<Map<String, dynamic>>> loadItems() async {
  final url =
  Uri.https('wallletapp-22ffc-default-rtdb.firebaseio.com', 'wallets.json');
  final response = await http.get(url);
  final walletsData = json.decode(response.body) as Map<String, dynamic>;

  final List<Map<String, dynamic>> itemsList = [];
  walletsData.forEach((key, value) {
    final Map<String, dynamic> item = Map.from(value);
    item['id'] = key;
    itemsList.add(item);
  });

  return itemsList;
}

// Основной виджет страницы депозитов.
class DepositsPage extends StatefulWidget {
  const DepositsPage({Key? key}) : super(key: key);

  @override
  State<DepositsPage> createState() => _DepositsPageState();
}

class _DepositsPageState extends State<DepositsPage> {
  late Future<void> _fetchWalletsDataFuture;

  @override
  void initState() {
    super.initState();
    _fetchWalletsDataFuture = fetchWalletsData();
  }

  // Функция для загрузки данных о кошельках и обновления состояния.
  Future<void> fetchWalletsData() async {
    walletsList = await loadItems();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () {
        setState(() {
          _fetchWalletsDataFuture = fetchWalletsData();
        });
        return _fetchWalletsDataFuture;
      },
      child: FutureBuilder<void>(
        future: _fetchWalletsDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong!'));
          } else {
            return (walletsList.isNotEmpty)
                ? ListView(
              children: [
                Row(
                  children: [
                    Text(
                      (selectedLanguage == 'ru')
                          ? 'Добрый день, \Пользователь!'
                          : (selectedLanguage == 'kz')
                          ? 'Сәлеметсіз бе, \nПайдаланушы!'
                          : 'Hello, \nUser!',
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.left,
                    ),
                    Spacer(),
                    CircleAvatar(
                      minRadius: 30,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      (selectedLanguage == 'ru') ? 'Кошельки' :
                      (selectedLanguage == 'kz') ? 'Әмияндар' : 'Wallets',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return NewWalletPage(
                                  typeOfWallet: 'wallet',
                                );
                              }));
                          walletsList = await loadItems();
                          setState(() {});
                        },
                        icon: Icon(Icons.add))
                  ],
                ),
                Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 1,
                  child: SizedBox(
                    height: 130,
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: walletsList.length,
                              itemBuilder: (context, index) {
                                final wallet = walletsList[index];
                                if (wallet['type'] == 'wallet') {
                                  return InkWell(
                                    onTap: () async {
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return EditWalletDialog(
                                                typeOfWallet: 'wallet',
                                                walletData: wallet);
                                          },
                                        ),
                                      );
                                      fetchWalletsData();
                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: WalletIcon(
                                        walletData: wallet,
                                        amount: wallet['money'] ?? 0,
                                        name: wallet['name'] ?? '',
                                        color: Colors.yellow,
                                        iconData:
                                        Icons.monetization_on_rounded,
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox(); // Пустой SizedBox для других типов.
                                }
                              },
                            )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    Text(
                      (selectedLanguage == 'ru')
                          ? 'Расходы'
                          : (selectedLanguage == 'kz')
                          ? 'Шығындар'
                          : 'Expenses',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    IconButton(
                        onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return NewWalletPage(
                                  typeOfWallet: 'rashod',
                                );
                              }));
                          fetchWalletsData();
                        },
                        icon: Icon(Icons.add))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 1,
                  child: SizedBox(
                    height: 130,
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: walletsList.length,
                              itemBuilder: (context, index) {
                                final wallet = walletsList[index];
                                if (wallet['type'] == 'rashod') {
                                  return InkWell(
                                    onTap: () async {
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return EditWalletDialog(
                                                typeOfWallet: 'rashod',
                                                walletData: wallet);
                                          },
                                        ),
                                      );
                                      await fetchWalletsData();
                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: WalletIcon(
                                        walletData: wallet,
                                        amount: wallet['money'] ?? 0,
                                        name: wallet['name'] ?? '',
                                        color: Colors.yellow,
                                        iconData:
                                        Icons.monetization_on_rounded,
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox(); // Пустой SizedBox для других типов.
                                }
                              },
                            )),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      (selectedLanguage != 'en') ? 'Депозиты' :
                      (selectedLanguage == 'kz') ? 'Депозиттер' : 'Deposit',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),

                    IconButton(
                        onPressed: () async {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) {
                                return NewWalletPage(
                                  typeOfWallet: 'deposit',
                                );
                              }));

                          setState(() async {
                            await fetchWalletsData();
                          });
                        },
                        icon: Icon(Icons.add))
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Material(
                  borderRadius: BorderRadius.circular(5),
                  elevation: 1,
                  child: SizedBox(
                    height: 130,
                    child: Column(
                      children: [
                        Expanded(
                            child: ListView.builder(
                              physics: AlwaysScrollableScrollPhysics(),
                              scrollDirection: Axis.horizontal,
                              itemCount: walletsList.length,
                              itemBuilder: (context, index) {
                                final wallet = walletsList[index];
                                if (wallet['type'] == 'deposit') {
                                  return InkWell(
                                    onTap: () async {
                                      await Navigator.of(context).push(
                                        MaterialPageRoute(
                                          builder: (context) {
                                            return EditWalletDialog(
                                                typeOfWallet: 'deposit',
                                                walletData: wallet);
                                          },
                                        ),
                                      );
                                      fetchWalletsData();
                                      setState(() {});
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: WalletIcon(
                                        walletData: wallet,
                                        amount: wallet['money'] ?? 0,
                                        name: wallet['name'] ?? '',
                                        color: Colors.yellow,
                                        iconData:
                                        Icons.monetization_on_rounded,
                                      ),
                                    ),
                                  );
                                } else {
                                  return SizedBox(); // Пустой SizedBox для других типов.
                                }
                              },
                            )),
                      ],
                    ),
                  ),
                ),
              ],
            )
                : Center(
              child: Text(
                (selectedLanguage == 'en')
                    ? 'Check your internet connection'
                    : (selectedLanguage == 'kz')
                    ? 'Интернет байланыстыңызды тексеріңіз'
                    : 'Проверьте свое интернет подключение',
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
