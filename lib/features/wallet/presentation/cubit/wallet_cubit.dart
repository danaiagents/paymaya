import 'package:bloc/bloc.dart';
import 'package:paymaya/core/usecases/usecase.dart';
import 'package:paymaya/core/utils/logger.dart';

import '../../domain/usecases/get_transactions.dart';
import '../../domain/usecases/get_wallet.dart';
import '../../domain/usecases/send_money.dart';
import 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  final GetWallet getWallet;
  final GetTransactions getTransactions;
  final SendMoney sendMoney;

  WalletCubit({
    required this.getWallet,
    required this.getTransactions,
    required this.sendMoney,
  }) : super(WalletInitial());

  Future<void> loadWallet() async {
    logger.i('Loading wallet...');
    emit(WalletLoading());
    final walletEither = await getWallet(NoParams());
    final transactionsEither = await getTransactions(NoParams());

    walletEither.fold(
      (failure) {
        logger.e('Failed to load wallet: $failure');
        emit(const WalletError(message: 'Failed to load wallet'));
      },
      (wallet) {
        transactionsEither.fold(
          (failure) {
            logger.e('Failed to load transactions: $failure');
            emit(const WalletError(message: 'Failed to load transactions'));
          },
          (transactions) {
            logger.i('Wallet loaded successfully');
            emit(WalletLoaded(wallet: wallet, transactions: transactions));
          },
        );
      },
    );
  }

  Future<void> send(double amount) async {
    logger.i('Sending money...');
    final result = await sendMoney(SendMoneyParams(amount: amount));
    result.fold(
      (failure) {
        logger.e('Failed to send money: $failure');
        emit(const WalletError(message: 'Failed to send money'));
      },
      (_) {
        logger.i('Money sent successfully');
        loadWallet();
      },
    );
  }
}
