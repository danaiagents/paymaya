import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:paymaya/features/wallet/data/models/wallet_model.dart';
import 'package:paymaya/features/wallet/domain/entities/wallet.dart';

import '../../../../fixtures/fixture_reader.dart';

void main() {
  const tWalletModel = WalletModel(balance: 500.0);

  test('should be a subclass of Wallet entity', () async {
    // assert
    expect(tWalletModel, isA<Wallet>());
  });

  group('fromJson', () {
    test(
      'should return a valid model when the JSON balance is a double',
      () async {
        // arrange
        final Map<String, dynamic> jsonMap = json.decode(
          fixture('wallet.json'),
        );
        // act
        final result = WalletModel.fromJson(jsonMap);
        // assert
        expect(result, tWalletModel);
      },
    );
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      // act
      final result = tWalletModel.toJson();
      // assert
      final expectedMap = {"balance": 500.0};
      expect(result, expectedMap);
    });
  });
}
