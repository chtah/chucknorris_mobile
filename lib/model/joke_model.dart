class Joke {
  dynamic categories;
  String createdAt;
  String iconUrl;
  String id;
  String updatedAt;
  String url;
  String value;

  Joke({
    required this.categories,
    required this.createdAt,
    required this.iconUrl,
    required this.id,
    required this.updatedAt,
    required this.url,
    required this.value,
  });

  factory Joke.fromJson(Map<String, dynamic> json) {
    return Joke(
      categories: json['categories'],
      createdAt: json['created_at'],
      iconUrl: json['icon_url'],
      id: json['id'],
      updatedAt: json['updated_at'],
      url: json['url'],
      value: json['value'],
    );
  }
}
