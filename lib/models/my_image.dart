import 'user.dart';

class MyImage {
  String id;
  String title;
  String urlSmall;
  String urlRegular;
  String description;
  String createdDate;
  String updatedDate;
  String width;
  String height;
  String likes;
  User user;

  MyImage({
    required this.id,
    required this.title,
    required this.urlSmall,
    required this.urlRegular,
    required this.description,
    required this.createdDate,
    required this.updatedDate,
    required this.width,
    required this.height,
    required this.likes,
    required this.user,
  });
}
