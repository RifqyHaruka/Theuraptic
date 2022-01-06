class ArticleModel {
  int? id;
  String? title;
  String? content;
  DateTime? createdAt;

  ArticleModel(this.id, this.title, this.content, this.createdAt);

  ArticleModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    content = json['content'];
    createdAt = DateTime.parse(json['created_at']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'created_at': createdAt.toString()
    };
  }
}
