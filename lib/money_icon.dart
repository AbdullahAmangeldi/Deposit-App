import 'package:deposit_app/editwallet.dart';
import 'package:flutter/material.dart';

class WalletIcon extends StatelessWidget {
  const WalletIcon({super.key, required this.amount, required this.name, required this.color, required this.iconData, required this.walletData});
  final Color color;
  final IconData iconData;
  final Map<String, dynamic> walletData;

  final int amount;
  final String name;

  @override
  Widget build(BuildContext context) {
    return  Column(
      children: [
        Text(name),
        CircleAvatar(
          radius: 30,
          backgroundColor: color,
          child: Icon(iconData, size: 50),

        ),
        Text(amount.toString() + 'тг')
      ],
    );
  }
}
