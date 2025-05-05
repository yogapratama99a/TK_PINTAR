class ChatMessage {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timestamp;

  ChatMessage({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timestamp,
  });

  // Convert ke Map (buat simpan ke Firestore)
  Map<String, dynamic> toMap() {
    return {
      'sender_id': senderId,
      'receiver_id': receiverId,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  // Convert dari Map (buat ambil dari Firestore)
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      senderId: map['sender_id'],
      receiverId: map['receiver_id'],
      message: map['message'],
      timestamp: DateTime.parse(map['timestamp']),
    );
  }
}
