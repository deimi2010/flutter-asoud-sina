class PaymentModel {
  final String id;
  final double amount;
  final String status;
  final String? gateway;
  final String? targetContent;
  final String? targetId;
  final DateTime createdAt;
  final DateTime? updatedAt;
  final String? transactionId;
  final String? referenceId;

  PaymentModel({
    required this.id,
    required this.amount,
    required this.status,
    this.gateway,
    this.targetContent,
    this.targetId,
    required this.createdAt,
    this.updatedAt,
    this.transactionId,
    this.referenceId,
  });

  factory PaymentModel.fromJson(Map<String, dynamic> json) {
    return PaymentModel(
      id: json['id']?.toString() ?? '',
      amount: (json['amount'] ?? 0.0).toDouble(),
      status: json['status']?.toString() ?? '',
      gateway: json['gateway']?.toString(),
      targetContent: json['target_content']?.toString(),
      targetId: json['target_id']?.toString(),
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : DateTime.now(),
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'])
          : null,
      transactionId: json['transaction_id']?.toString(),
      referenceId: json['reference_id']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'status': status,
      'gateway': gateway,
      'target_content': targetContent,
      'target_id': targetId,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
      'transaction_id': transactionId,
      'reference_id': referenceId,
    };
  }
}

