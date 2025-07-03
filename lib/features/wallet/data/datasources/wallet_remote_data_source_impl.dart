import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:paymaya/core/utils/logger.dart';

import '../../../../core/error/exceptions.dart';
import '../models/transaction_model.dart';
import '../models/wallet_model.dart';
import 'wallet_remote_data_source.dart';

class WalletRemoteDataSourceImpl implements WalletRemoteDataSource {
  final http.Client client;

  WalletRemoteDataSourceImpl({required this.client});

  @override
  Future<WalletModel> getWallet() async {
    const url = 'https://jsonplaceholder.typicode.com/users/1';
    logger.i('API Endpoint: $url');
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    logger.i('API Response: ${response.body}');

    if (response.statusCode == 200) {
      return WalletModel.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TransactionModel>> getTransactions() async {
    const url = 'https://jsonplaceholder.typicode.com/posts';
    logger.i('API Endpoint: $url');
    final response = await client.get(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
    );
    logger.i('API Response: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => TransactionModel.fromJson(json)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> sendMoney(double amount) async {
    const url = 'https://jsonplaceholder.typicode.com/posts';
    logger.i('API Endpoint: $url');
    final response = await client.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({'amount': amount}),
    );
    logger.i('API Response: ${response.body}');

    if (response.statusCode != 201) {
      throw ServerException();
    }
  }
}
