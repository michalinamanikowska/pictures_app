class User {
  String name;
  String image;
  String? instagram;
  String? twitter;

  User({
    required this.name,
    required this.image,
    this.instagram,
    this.twitter,
  });
}
