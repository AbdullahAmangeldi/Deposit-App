import 'package:deposit_app/createnewwallet.dart';
import 'package:flutter/material.dart';

class WalletDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Choose a Wallet Option'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildOption(context, 'Wallet', 'Manage your wallet.'),
          _buildOption(context, 'Deposit', 'Make a deposit.'),
          _buildOption(context, 'Category', 'Manage spending categories.'),
        ],
      ),
    );
  }

  Widget _buildOption(BuildContext context, String title, String description) {
    return ListTile(
      trailing: Icon(Icons.monetization_on_rounded),
      title: Text(title),
      subtitle: Text(description),
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            builder: (context) {
              return NewWalletPage(
                typeOfWallet: '',
              );
            },
          ),
        );
      },
    );
  }
}
