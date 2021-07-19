import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/my_image.dart';

class ImagesRepository {
  Future<List<dynamic>> getImages(String searchValue) async {
    final url = Uri.parse(
        'https://api.unsplash.com/search/photos?per_page=30&query=$searchValue&client_id=djkF0imZLQieLADtwAEz1_7xeOXFFv5P5appQEHgvkQ');
    var response = await http.get(url);
    if (response.statusCode != 200) throw Exception();
    var data = json.decode(response.body);
    List downloadedData = [];
    data['results'].forEach(
      (element) {
        final image = MyImage.fromJson(element, searchValue);
        downloadedData.add(image);
      },
    );
    return downloadedData;
  }
}
