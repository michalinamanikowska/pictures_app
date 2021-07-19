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
}
