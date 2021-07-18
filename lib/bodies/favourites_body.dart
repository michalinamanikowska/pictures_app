import 'package:flutter/material.dart';
import '../widgets/custom_container.dart';
import '../screens/details_screen.dart';
import '../db/database_helper.dart';

class FavouritesBody extends StatefulWidget {
  @override
  _FavouritesBodyState createState() => _FavouritesBodyState();
}

class _FavouritesBodyState extends State<FavouritesBody> {
  final dbHelper = DatabaseHelper.instance;
  List favouriteImages = [];

  Future<bool> loadImages() async {
    favouriteImages = await dbHelper.getImages();
    return true;
  }

  createAlertDialog(BuildContext context, int index) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Confirm'),
              content: Text("Are you sure you want to delete this picture?"),
              actions: [
                TextButton(
                    child: Text("No"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    }),
                TextButton(
                    child: Text("Yes",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    onPressed: () {
                      deleteImage(context, index);
                      Navigator.of(context).pop();
                    }),
              ]);
        });
  }

  void deleteImage(ctx, index) {
    dbHelper.delete(favouriteImages[index].id);
    ScaffoldMessenger.of(ctx).showSnackBar(
      SnackBar(
        content: Text(
            'Picture ${favouriteImages[index].title} removed from favorites.'),
      ),
    );
    setState(() {
      favouriteImages.removeAt(index);
    });
  }

  Widget buildContent(BuildContext ctx, int index) {
    return Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10.0),
          child: Image.network(
            favouriteImages[index].urlSmall,
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
          child: Center(
            child: Text(
              favouriteImages[index].title,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        IconButton(
          icon: Icon(Icons.delete, color: Theme.of(context).primaryColor),
          onPressed: () => createAlertDialog(context, index),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: loadImages(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return favouriteImages.length != 0
              ? ListView.builder(
                  itemCount: favouriteImages.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      child: CustomContainer(
                        child: buildContent(context, index),
                      ),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  DetailsScreen(favouriteImages[index]),
                              settings: RouteSettings(arguments: false))),
                    );
                  },
                )
              : Center(
                  child: Text('There are no favorite pictures.',
                      style: TextStyle(fontSize: 18)));
        } else
          return Center(child: CircularProgressIndicator());
      },
    );
  }
}
