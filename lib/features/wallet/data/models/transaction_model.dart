import '../../domain/entities/transaction.dart';

class TransactionModel extends Transaction {
  const TransactionModel({
    required super.id,
    required super.amount,
    required super.date,
    required super.type,
    required super.recipient,
    required super.sender,
  });

  factory TransactionModel.fromJson(Map<String, dynamic> json) {
    return TransactionModel(
      id: json['id'].toString(),
      amount: 100.0,
      date: DateTime.now(),
      type: TransactionType.sent,
      recipient: 'John Doe',
      sender: 'Jane Doe',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'date': date.toIso8601String(),
      'type': type.toString().split('.').last,
      'recipient': recipient,
      'sender': sender,
    };
  }
}
