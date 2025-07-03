import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:paymaya/core/error/exceptions.dart';
import 'package:paymaya/core/error/failures.dart';
import 'package:paymaya/features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'package:paymaya/features/wallet/data/models/transaction_model.dart';
import 'package:paymaya/features/wallet/data/models/wallet_model.dart';
import 'package:paymaya/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:paymaya/features/wallet/domain/entities/transaction.dart';

import 'wallet_repository_impl_test.mocks.dart';

@GenerateMocks([WalletRemoteDataSource])
void main() {
  late WalletRepositoryImpl repository;
  late MockWalletRemoteDataSource mockRemoteDataSource;

  setUp(() {
    mockRemoteDataSource = MockWalletRemoteDataSource();
    repository = WalletRepositoryImpl(remoteDataSource: mockRemoteDataSource);
  });

  group('getWallet', () {
    const tWalletModel = WalletModel(balance: 500.0);
    const tWallet = tWalletModel;

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getWallet(),
        ).thenAnswer((_) async => tWalletModel);
        // act
        final result = await repository.getWallet();
        // assert
        verify(mockRemoteDataSource.getWallet());
        expect(result, equals(const Right(tWallet)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.getWallet()).thenThrow(ServerException());
        // act
        final result = await repository.getWallet();
        // assert
        verify(mockRemoteDataSource.getWallet());
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  group('getTransactions', () {
    final tTransactionModelList = [
      TransactionModel(
        id: '1',
        amount: 100.0,
        date: DateTime.parse('2023-01-01T12:00:00.000Z'),
        type: TransactionType.sent,
        recipient: 'John Doe',
        sender: 'Jane Doe',
      ),
    ];
    final tTransactionList = tTransactionModelList;

    test(
      'should return remote data when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTransactions(),
        ).thenAnswer((_) async => tTransactionModelList);
        // act
        final result = await repository.getTransactions();
        // assert
        verify(mockRemoteDataSource.getTransactions());
        expect(result, equals(Right(tTransactionList)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.getTransactions(),
        ).thenThrow(ServerException());
        // act
        final result = await repository.getTransactions();
        // assert
        verify(mockRemoteDataSource.getTransactions());
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });

  group('sendMoney', () {
    const tAmount = 100.0;

    test(
      'should return unit when the call to remote data source is successful',
      () async {
        // arrange
        when(
          mockRemoteDataSource.sendMoney(any),
        ).thenAnswer((_) async => Future.value());
        // act
        final result = await repository.sendMoney(tAmount);
        // assert
        verify(mockRemoteDataSource.sendMoney(tAmount));
        expect(result, equals(const Right(unit)));
      },
    );

    test(
      'should return server failure when the call to remote data source is unsuccessful',
      () async {
        // arrange
        when(mockRemoteDataSource.sendMoney(any)).thenThrow(ServerException());
        // act
        final result = await repository.sendMoney(tAmount);
        // assert
        verify(mockRemoteDataSource.sendMoney(tAmount));
        expect(result, equals(Left(ServerFailure())));
      },
    );
  });
}
