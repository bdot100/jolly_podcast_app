class Podcast {
  final String? id;
  final String? title;
  final String? description;
  final String? thumbnail;
  final String? audioUrl;
  final String? author;

  Podcast({
    this.id,
    this.title,
    this.description,
    this.thumbnail,
    this.audioUrl,
    this.author,
  });

  factory Podcast.fromJson(Map<String, dynamic> json) {
    return Podcast(
      id: json['id']?.toString() ?? json['_id']?.toString(),
      title: json['title'] ?? json['name'],
      description: json['description'],
      thumbnail: json['picture_url'] ?? json['thumbnail'] ?? json['image'] ?? json['imageUrl'],
      audioUrl: json['content_url'] ?? json['audio'] ?? json['file'] ?? json['url'],
      author: json['podcast']?['author'] ?? json['author'],
    );
  }
}
