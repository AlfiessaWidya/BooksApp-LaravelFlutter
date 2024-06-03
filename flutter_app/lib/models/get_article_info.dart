class ArticleInfo {
  final int id;
  final String article_content;
  final String title;
  final String description;
  final String created_at;
  final String img;
  final String author;

  ArticleInfo({
    required this.id,
    required this.article_content,
    required this.title,
    required this.description,
    required this.created_at,
    required this.img,
    required this.author,
  });

  factory ArticleInfo.fromJson(Map<String, dynamic> json) {
    return ArticleInfo(
      id: json['id'],
      author: json['author'],
      article_content: json['article_content'],
      description: json['description'],
      title: json['title'],
      created_at: json['created_at'],
      img: json['img'],
    );
  }

  toJson() {
    return {
      'id': id,
      'article_content': article_content,
      'title': title,
      'description': description,
      'created_at': created_at,
      'img': img,
      'author': author,
    };
  }
}
