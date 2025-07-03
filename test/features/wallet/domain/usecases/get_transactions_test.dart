import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paymaya/core/usecases/usecase.dart';
import 'package:paymaya/features/wallet/domain/entities/transaction.dart';
import 'package:paymaya/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:paymaya/features/wallet/domain/usecases/get_transactions.dart';

import 'get_transactions_test.mocks.dart';

@GenerateMocks([WalletRepository])
void main() {
  late GetTransactions usecase;
  late MockWalletRepository mockWalletRepository;

  setUp(() {
    mockWalletRepository = MockWalletRepository();
    usecase = GetTransactions(mockWalletRepository);
  });

  final tTransactions = [
    Transaction(
      id: '1',
      amount: 100.0,
      date: DateTime.parse('2023-01-01T12:00:00.000Z'),
      type: TransactionType.sent,
      recipient: 'John Doe',
      sender: 'Jane Doe',
    ),
  ];

  test('should get list of transactions from the repository', () async {
    // arrange
    when(
      mockWalletRepository.getTransactions(),
    ).thenAnswer((_) async => Right(tTransactions));
    // act
    final result = await usecase(NoParams());
    // assert
    expect(result, Right(tTransactions));
    verify(mockWalletRepository.getTransactions());
    verifyNoMoreInteractions(mockWalletRepository);
  });
}
