import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:paymaya/core/utils/app_strings.dart';

import '../cubit/wallet_cubit.dart';
import '../cubit/wallet_state.dart';

class TransactionHistoryScreen extends StatelessWidget {
  const TransactionHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF121712),
      appBar: AppBar(
        backgroundColor: const Color(0xFF121712),
        title: const Text(
          AppStrings.activity,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        color: const Color(0xFF121712),
        child: BlocBuilder<WalletCubit, WalletState>(
          builder: (context, state) {
            if (state is WalletLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is WalletLoaded) {
              return ListView.builder(
                itemCount: state.transactions.length,
                itemBuilder: (context, index) {
                  final transaction = state.transactions[index];
                  final isSent = index % 2 == 0;
                  return ListTile(
                    leading: const CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/150?img=68',
                      ),
                    ),
                    title: Text(
                      '${isSent ? AppStrings.sent : AppStrings.received} • \$${transaction.amount.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    ),
                    subtitle: Text(
                      '10:15 AM',
                      style: TextStyle(color: Colors.grey[400], fontSize: 14),
                    ),
                  );
                },
              );
            } else if (state is WalletError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            return const Center(
              child: Text(
                AppStrings.noTransactionsYet,
                style: TextStyle(color: Colors.white),
              ),
            );
          },
        ),
      ),
    );
  }
}
