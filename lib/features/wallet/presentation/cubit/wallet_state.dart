import 'package:equatable/equatable.dart';

import '../../domain/entities/transaction.dart';
import '../../domain/entities/wallet.dart';

abstract class WalletState extends Equatable {
  const WalletState();

  @override
  List<Object> get props => [];
}

class WalletInitial extends WalletState {}

class WalletLoading extends WalletState {}

class WalletLoaded extends WalletState {
  final Wallet wallet;
  final List<Transaction> transactions;

  const WalletLoaded({required this.wallet, required this.transactions});

  @override
  List<Object> get props => [wallet, transactions];
}

class WalletError extends WalletState {
  final String message;

  const WalletError({required this.message});

  @override
  List<Object> get props => [message];
}
