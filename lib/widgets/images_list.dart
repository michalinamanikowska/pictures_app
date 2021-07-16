import 'package:flutter/material.dart';
import 'package:giraffe_app/models/user.dart';
import '../models/my_image.dart';
import '../screens/details_screen.dart';
import 'custom_container.dart';

class ImagesList extends StatelessWidget {
  final List images;
  ImagesList(this.images);

  String supportNull(value) {
    var result;
    value == null ? result = '' : result = value;
    if (result is int) result = result.toString();
    return result;
  }

  void goToDetails(cxt, i) {
    final user = User(
      name: supportNull(images[i]['user']['name']),
      image: supportNull(images[i]['user']['profile_image']['large']),
      instagram: supportNull(images[i]['user']['instagram_username']),
      twitter: supportNull(images[i]['user']['twitter_username']),
    );

    final image = MyImage(
      id: images[i]['id'],
      title: supportNull(images[i]['id']),
      urlSmall: supportNull(images[i]['urls']['small']),
      urlRegular: supportNull(images[i]['urls']['small']),
      description: supportNull(images[i]['description']),
      createdDate: supportNull(images[i]['created_at']),
      updatedDate: supportNull(images[i]['updated_at']),
      width: supportNull(images[i]['width']),
      height: supportNull(images[i]['height']),
      likes: supportNull(images[i]['likes']),
      user: user,
    );
    Navigator.push(
        cxt,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(image),
            settings: RouteSettings(arguments: true)));
  }

  Widget buildContent(index) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            images[index]['urls']['small'],
            width: 120,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return CircularProgressIndicator();
            },
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Center(
              child: Text(
                images[index]['id'],
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            child: CustomContainer(
              child: buildContent(index),
            ),
            onTap: () => goToDetails(context, index),
          );
        });
  }
}
