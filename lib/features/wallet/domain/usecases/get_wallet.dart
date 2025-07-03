import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/wallet.dart';
import '../repositories/wallet_repository.dart';

class GetWallet implements UseCase<Wallet, NoParams> {
  final WalletRepository repository;

  GetWallet(this.repository);

  @override
  Future<Either<Failure, Wallet>> call(NoParams params) async {
    return await repository.getWallet();
  }
}
