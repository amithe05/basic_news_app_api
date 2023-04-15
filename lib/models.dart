class NewsItem {
  final String id;
  final String title;
  final String description;
  final String imageUrl;

  NewsItem({required this.id, required this.title, required this.description, required this.imageUrl});

  factory NewsItem.fromJson(Map<String, dynamic> json) {
    return NewsItem(
      id: json['_id'],
      title: json['title'],
      description: json['description'],
      imageUrl: json['imageUrl'],
    );
  }
}