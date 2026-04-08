class Order {
  final int? id;
  final int userId;
  final double totalAmount;
  final String status; // pending, preparing, delivered
  final String createdAt;

  Order({
    this.id,
    required this.userId,
    required this.totalAmount,
    required this.status,
    required this.createdAt,
  });

  factory Order.fromMap(Map<String, dynamic> map) {
    return Order(
      id: map['id'],
      userId: map['user_id'],
      totalAmount: map['total_amount'],
      status: map['status'],
      createdAt: map['created_at'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_id': userId,
      'total_amount': totalAmount,
      'status': status,
      'created_at': createdAt,
    };
  }
}
