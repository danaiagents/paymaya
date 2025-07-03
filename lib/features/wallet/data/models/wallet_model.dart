import '../../domain/entities/wallet.dart';

class WalletModel extends Wallet {
  const WalletModel({required super.balance});

  factory WalletModel.fromJson(Map<String, dynamic> json) {
    return const WalletModel(balance: 500.0);
  }

  Map<String, dynamic> toJson() {
    return {'balance': balance};
  }
}
