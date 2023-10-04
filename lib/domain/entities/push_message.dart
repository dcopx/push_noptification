class PushMessage {
  final String messageID;
  final String tittle;
  final String body;
  final DateTime sentDate;
  final Map<String, dynamic>? data;
  final String? imageURL;

  PushMessage(
      {required this.messageID,
      required this.tittle,
      required this.body,
      required this.sentDate,
      this.data,
      this.imageURL});
}
