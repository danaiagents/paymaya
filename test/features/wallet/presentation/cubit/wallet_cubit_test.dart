import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paymaya/core/error/failures.dart';
import 'package:paymaya/core/usecases/usecase.dart';
import 'package:paymaya/features/wallet/domain/entities/transaction.dart';
import 'package:paymaya/features/wallet/domain/entities/wallet.dart';
import 'package:paymaya/features/wallet/domain/usecases/get_transactions.dart';
import 'package:paymaya/features/wallet/domain/usecases/get_wallet.dart';
import 'package:paymaya/features/wallet/domain/usecases/send_money.dart';
import 'package:paymaya/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:paymaya/features/wallet/presentation/cubit/wallet_state.dart';

import 'wallet_cubit_test.mocks.dart';

@GenerateMocks([GetWallet, GetTransactions, SendMoney])
void main() {
  late WalletCubit cubit;
  late MockGetWallet mockGetWallet;
  late MockGetTransactions mockGetTransactions;
  late MockSendMoney mockSendMoney;

  setUp(() {
    mockGetWallet = MockGetWallet();
    mockGetTransactions = MockGetTransactions();
    mockSendMoney = MockSendMoney();
    cubit = WalletCubit(
      getWallet: mockGetWallet,
      getTransactions: mockGetTransactions,
      sendMoney: mockSendMoney,
    );
  });

  const tWallet = Wallet(balance: 500.0);
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
  const tAmount = 100.0;

  test('initialState should be WalletInitial', () {
    expect(cubit.state, equals(WalletInitial()));
  });

  group('loadWallet', () {
    blocTest<WalletCubit, WalletState>(
      'should emit [WalletLoading, WalletLoaded] when data is gotten successfully',
      build: () {
        when(
          mockGetWallet(NoParams()),
        ).thenAnswer((_) async => const Right(tWallet));
        when(
          mockGetTransactions(NoParams()),
        ).thenAnswer((_) async => Right(tTransactions));
        return cubit;
      },
      act: (cubit) => cubit.loadWallet(),
      expect:
          () => [
            WalletLoading(),
            WalletLoaded(wallet: tWallet, transactions: tTransactions),
          ],
    );

    blocTest<WalletCubit, WalletState>(
      'should emit [WalletLoading, WalletError] when getWallet fails',
      build: () {
        when(
          mockGetWallet(NoParams()),
        ).thenAnswer((_) async => Left(ServerFailure()));
        when(
          mockGetTransactions(NoParams()),
        ).thenAnswer((_) async => Right(tTransactions));
        return cubit;
      },
      act: (cubit) => cubit.loadWallet(),
      expect:
          () => [
            WalletLoading(),
            const WalletError(message: 'Failed to load wallet'),
          ],
    );

    blocTest<WalletCubit, WalletState>(
      'should emit [WalletLoading, WalletError] when getTransactions fails',
      build: () {
        when(
          mockGetWallet(NoParams()),
        ).thenAnswer((_) async => const Right(tWallet));
        when(
          mockGetTransactions(NoParams()),
        ).thenAnswer((_) async => Left(ServerFailure()));
        return cubit;
      },
      act: (cubit) => cubit.loadWallet(),
      expect:
          () => [
            WalletLoading(),
            const WalletError(message: 'Failed to load transactions'),
          ],
    );
  });

  group('sendMoney', () {
    blocTest<WalletCubit, WalletState>(
      'should emit [WalletLoading, WalletLoaded] when money is sent successfully',
      build: () {
        when(
          mockSendMoney(const SendMoneyParams(amount: tAmount)),
        ).thenAnswer((_) async => const Right(unit));
        when(
          mockGetWallet(NoParams()),
        ).thenAnswer((_) async => const Right(tWallet));
        when(
          mockGetTransactions(NoParams()),
        ).thenAnswer((_) async => Right(tTransactions));
        return cubit;
      },
      act: (cubit) => cubit.send(tAmount),
      expect:
          () => [
            WalletLoading(),
            WalletLoaded(wallet: tWallet, transactions: tTransactions),
          ],
    );

    blocTest<WalletCubit, WalletState>(
      'should emit [WalletError] when sending money fails',
      build: () {
        when(
          mockSendMoney(const SendMoneyParams(amount: tAmount)),
        ).thenAnswer((_) async => Left(ServerFailure()));
        return cubit;
      },
      act: (cubit) => cubit.send(tAmount),
      expect: () => [const WalletError(message: 'Failed to send money')],
    );
  });
}
