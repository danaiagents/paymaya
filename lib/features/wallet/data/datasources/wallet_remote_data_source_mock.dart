import 'dart:convert';

import 'package:paymaya/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:paymaya/features/wallet/data/models/transaction_model.dart';
import 'package:paymaya/features/wallet/data/models/wallet_model.dart';

class WalletRemoteDataSourceMock implements WalletRemoteDataSource {
  @override
  Future<WalletModel> getWallet() async {
    await Future.delayed(const Duration(seconds: 1));
    return WalletModel.fromJson(
      json.decode('''
      {
        "balance": 500.0
      }
      '''),
    );
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    await Future.delayed(const Duration(seconds: 1));
    return (json.decode('''
      [
        {
          "id": "1",
          "amount": 20.0,
          "date": "2023-07-03T12:30:00.000Z",
          "type": "sent",
          "recipient": "John Doe",
          "sender": "Jane Doe"
        },
        {
          "id": "2",
          "amount": 15.0,
          "date": "2023-07-03T11:45:00.000Z",
          "type": "received",
          "recipient": "Jane Doe",
          "sender": "John Doe"
        },
        {
          "id": "3",
          "amount": 30.0,
          "date": "2023-07-03T10:15:00.000Z",
          "type": "sent",
          "recipient": "John Doe",
          "sender": "Jane Doe"
        }
      ]
      ''')
            as List)
        .map((data) => TransactionModel.fromJson(data))
        .toList();
  }

  @override
  Future<void> sendMoney(double amount) async {
    await Future.delayed(const Duration(seconds: 1));
  }
}
