import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:paymaya/features/wallet/data/datasources/wallet_remote_data_source_impl.dart';
import 'package:paymaya/features/wallet/data/repositories/wallet_repository_impl.dart';
import 'package:paymaya/features/wallet/domain/repositories/wallet_repository.dart';
import 'package:paymaya/features/wallet/domain/usecases/get_transactions.dart';
import 'package:paymaya/features/wallet/domain/usecases/send_money.dart';
import 'package:paymaya/features/wallet/presentation/cubit/wallet_cubit.dart';

import 'features/wallet/data/datasources/wallet_remote_data_source.dart';
import 'features/wallet/domain/usecases/get_wallet.dart';

final sl = GetIt.instance;

void init() {
  // Cubit
  sl.registerFactory(
    () => WalletCubit(getWallet: sl(), getTransactions: sl(), sendMoney: sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetWallet(sl()));
  sl.registerLazySingleton(() => GetTransactions(sl()));
  sl.registerLazySingleton(() => SendMoney(sl()));

  // Repository
  sl.registerLazySingleton<WalletRepository>(
    () => WalletRepositoryImpl(remoteDataSource: sl()),
  );

  // Data sources
  sl.registerLazySingleton<WalletRemoteDataSource>(
    () => WalletRemoteDataSourceImpl(client: sl()),
  );

  // External
  sl.registerLazySingleton(() => http.Client());
}
