import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paymaya/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:paymaya/features/wallet/domain/usecases/send_money.dart';

import 'send_money_test.mocks.dart';

@GenerateMocks([WalletRepository])
void main() {
  late SendMoney usecase;
  late MockWalletRepository mockWalletRepository;

  setUp(() {
    mockWalletRepository = MockWalletRepository();
    usecase = SendMoney(mockWalletRepository);
  });

  const tAmount = 100.0;

  test('should send money through the repository', () async {
    // arrange
    when(
      mockWalletRepository.sendMoney(tAmount),
    ).thenAnswer((_) async => const Right(unit));
    // act
    final result = await usecase(const SendMoneyParams(amount: tAmount));
    // assert
    expect(result, const Right(unit));
    verify(mockWalletRepository.sendMoney(tAmount));
    verifyNoMoreInteractions(mockWalletRepository);
  });
}
