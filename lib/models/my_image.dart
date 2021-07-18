import 'user.dart';

class MyImage {
  String id;
  String title;
  String urlSmall;
  String urlRegular;
  String? description;
  String? createdDate;
  String? updatedDate;
  int? width;
  int? height;
  int? likes;
  User user;

  MyImage({
    required this.id,
    required this.title,
    required this.urlSmall,
    required this.urlRegular,
    this.description,
    this.createdDate,
    this.updatedDate,
    this.width,
    this.height,
    this.likes,
    required this.user,
  });

  factory MyImage.fromJson(Map<String, dynamic> json) {
    final user = User(
      name: json['user']['name'],
      image: json['user']['profile_image']['large'],
      instagram: json['user']['instagram_username'],
      twitter: json['user']['twitter_username'],
    );

    final image = MyImage(
      id: json['id'],
      title: json['id'],
      urlSmall: json['urls']['small'],
      urlRegular: json['urls']['small'],
      description: json['description'],
      createdDate: json['created_at'],
      updatedDate: json['updated_at'],
      width: json['width'],
      height: json['height'],
      likes: json['likes'],
      user: user,
    );

    return image;
  }
}
