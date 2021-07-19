import 'package:flutter/material.dart';
import '../screens/details_screen.dart';
import 'custom_container.dart';

class ImagesList extends StatelessWidget {
  final List _images;
  ImagesList(this._images);

  void goToDetails(cxt, i) {
    Navigator.push(
        cxt,
        MaterialPageRoute(
            builder: (context) => DetailsScreen(_images[i]),
            settings: RouteSettings(arguments: true)));
  }

  Widget buildContent(index) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            _images[index].urlSmall,
            width: 120,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return CircularProgressIndicator();
            },
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Container(
                  constraints: BoxConstraints(maxWidth: 80),
                  child: Text(
                    'Couldn\'t load the picture',
                    textAlign: TextAlign.center,
                  ));
            },
          ),
        ),
        Expanded(
          child: Container(
            margin: EdgeInsets.fromLTRB(5, 0, 0, 0),
            child: Center(
              child: Text(
                _images[index].title,
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
        itemCount: _images.length,
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
