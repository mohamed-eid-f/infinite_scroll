class Post {
  final int id;
  final String title;
  final String body;

  Post({required this.id, required this.title, required this.body});

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'body': body,
        'title': title,
      };

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json['id'],
        body: json['body'],
        title: json['title'],
      );
}
