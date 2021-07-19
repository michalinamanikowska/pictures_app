import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/my_image.dart';
import '../models/user.dart';

class ImagesRepository {
  MyImage fromJson(Map<String, dynamic> json, String searchValue) {
    final user = User(
      name: json['user']['name'],
      image: json['user']['profile_image']['large'],
      instagram: json['user']['instagram_username'],
      twitter: json['user']['twitter_username'],
    );

    final image = MyImage(
      id: json['id'],
      title: json['description'] != null &&
              ' '.allMatches(json['description']).length < 5
          ? json['description']
          : searchValue,
      urlSmall: json['urls']['small'],
      urlRegular: json['urls']['regular'],
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

  Future<List<dynamic>> getImages(String searchValue) async {
    final url = Uri.parse(
        'https://api.unsplash.com/search/photos?per_page=30&query=$searchValue&client_id=djkF0imZLQieLADtwAEz1_7xeOXFFv5P5appQEHgvkQ');
    var response = await http.get(url);
    if (response.statusCode != 200) throw Exception();
    var data = json.decode(response.body);
    List downloadedData = [];
    data['results'].forEach(
      (element) {
        final image = fromJson(element, searchValue);
        downloadedData.add(image);
      },
    );
    return downloadedData;
  }
}
