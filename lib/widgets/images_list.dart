import 'package:flutter/material.dart';
import '../screens/details_screen.dart';
import 'custom_container.dart';

class ImagesList extends StatelessWidget {
  final List images;
  ImagesList(this.images);

  void goToDetails(cxt, i) {
    Navigator.push(
        cxt,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(images[i]),
            settings: RouteSettings(arguments: true)));
  }

  Widget buildContent(index) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            images[index].urlSmall,
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
                images[index].id,
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
