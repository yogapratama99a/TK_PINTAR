class ArticleModel {
  final int id;
  final String url;
  final String title;
  final String content;

  ArticleModel({
    required this.id,
    required this.url,
    required this.title,
    required this.content,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    final String rawUrl = json['url'] ?? '';
    final String fullUrl = rawUrl.isNotEmpty
        ? rawUrl
        : 'http://10.0.2.2:8000/default-image.jpg';

    return ArticleModel(
      id: json['id'] is int ? json['id'] : int.tryParse(json['id'].toString()) ?? 0,
      url: fullUrl,
      title: json['title']?.toString() ?? 'No Title Available',
      content: json['content']?.toString() ?? 'No Content Available',
    );
  }

  static List<ArticleModel> fromList(List<dynamic> data) {
    return data.map((item) => ArticleModel.fromJson(item)).toList();
  }
}
