class MessageModel {
  int? id;
  int? conversationId;
  String? userId;
  String? body;
  DateTime? createdAt;
  DateTime? updatedAt;

  MessageModel(
      {this.id,
      this.conversationId,
      this.userId,
      this.createdAt,
      this.updatedAt});

  MessageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    conversationId = json['conversation_id'];
    userId = json['user_id'];
    body = json['body'];
    createdAt = DateTime.parse(json['created_at']);
    updatedAt = DateTime.parse(json['updated_at']);
  }

  Map<String, dynamic> json() {
    return {
      'id': id,
      'conversation_id': conversationId,
      'user_id': userId,
      'body': body,
      'created_at': createdAt.toString(),
      'updated_at': updatedAt.toString()
    };
  }
}
