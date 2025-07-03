import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/wallet_repository.dart';

class SendMoney implements UseCase<Unit, SendMoneyParams> {
  final WalletRepository repository;

  SendMoney(this.repository);

  @override
  Future<Either<Failure, Unit>> call(SendMoneyParams params) async {
    return await repository.sendMoney(params.amount);
  }
}

class SendMoneyParams extends Equatable {
  final double amount;

  const SendMoneyParams({required this.amount});

  @override
  List<Object?> get props => [amount];
}
