class NewsItem {
  NewsItem({
    required this.category,
    required this.data,
    required this.success,
  });
  late final String category;
  late final List<Data> data;
  late final bool success;
  
  NewsItem.fromJson(Map<String, dynamic> json){
    category = json['category'];
    data = List.from(json['data']).map((e)=>Data.fromJson(e)).toList();
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['category'] = category;
    _data['data'] = data.map((e)=>e.toJson()).toList();
    _data['success'] = success;
    return _data;
  }
}

class Data {
  Data({
    required this.author,
    required this.content,
    required this.date,
    required this.id,
    required this.imageUrl,
     this.readMoreUrl,
    required this.time,
    required this.title,
    required this.url,
  });
  late final String author;
  late final String content;
  late final String date;
  late final String id;
  late final String? imageUrl;
  late final String? readMoreUrl;
  late final String time;
  late final String? title;
  late final String url;
  
  Data.fromJson(Map<String, dynamic> json){
    author = json['author'];
    content = json['content'];
    date = json['date'];
    id = json['id'];
    imageUrl = json['imageUrl'];
    readMoreUrl = null;
    time = json['time'];
    title = json['title'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['author'] = author;
    _data['content'] = content;
    _data['date'] = date;
    _data['id'] = id;
    _data['imageUrl'] = imageUrl;
    _data['readMoreUrl'] = readMoreUrl;
    _data['time'] = time;
    _data['title'] = title;
    _data['url'] = url;
    return _data;
  }
}