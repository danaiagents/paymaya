import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:paymaya/features/wallet/data/models/transaction_model.dart';
import 'package:paymaya/features/wallet/domain/entities/transaction.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  final tTransactionModel = TransactionModel(
    id: '1',
    amount: 100.0,
    date: DateTime.parse('2023-01-01T12:00:00.000Z'),
    type: TransactionType.sent,
    recipient: 'John Doe',
    sender: 'Jane Doe',
  );

  test('should be a subclass of Transaction entity', () async {
    // assert
    expect(tTransactionModel, isA<Transaction>());
  });

  group('fromJson', () {
    test('should return a valid model from the JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = json.decode(
        fixture('transaction.json'),
      );
      // act
      final result = TransactionModel.fromJson(jsonMap);
      // assert
      expect(result, tTransactionModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // act
      final result = tTransactionModel.toJson();
      // assert
      final expectedMap = {
        "id": "1",
        "amount": 100.0,
        "date": "2023-01-01T12:00:00.000Z",
        "type": "sent",
        "recipient": "John Doe",
        "sender": "Jane Doe",
      };
      expect(result, expectedMap);
    });
  });
}
