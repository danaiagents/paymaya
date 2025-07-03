import 'package:equatable/equatable.dart';

enum TransactionType { sent, received }

class Transaction extends Equatable {
  final String id;
  final double amount;
  final DateTime date;
  final TransactionType type;
  final String recipient;
  final String sender;

  const Transaction({
    required this.id,
    required this.amount,
    required this.date,
    required this.type,
    required this.recipient,
    required this.sender,
  });

  @override
  List<Object?> get props => [id, amount, date, type, recipient, sender];
}
