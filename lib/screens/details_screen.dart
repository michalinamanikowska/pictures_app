import 'package:flutter/material.dart';
import '../widgets/app_bar.dart';
import '../widgets/user_view.dart';
import '../models/my_image.dart';
import '../db/database_helper.dart';

class DetailsScreen extends StatefulWidget {
  final MyImage _currentImage;
  DetailsScreen(this._currentImage);

  @override
  _DetailsScreenState createState() => _DetailsScreenState();
}

class _DetailsScreenState extends State<DetailsScreen> {
  final dbHelper = DatabaseHelper.instance;
  bool favourite = false;

  void undo() {
    dbHelper.delete(widget._currentImage.id);
    setState(() {
      favourite = false;
    });
  }

  void addToFavourites(ctx) {
    if (!favourite) {
      dbHelper.insert(widget._currentImage);
      setState(() {
        favourite = true;
      });
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content: Text('Picture added to favorites.'),
          action: SnackBarAction(
            label: "Undo",
            onPressed: undo,
          ),
        ),
      );
    }
  }

  Future<bool> getData() async {
    final result = await dbHelper.checkIfExists(widget._currentImage);
    setState(() {
      favourite = result;
    });
    return true;
  }

  Widget buildDetails() {
    return SingleChildScrollView(
      child: Column(
        children: [
          Image.network(
            widget._currentImage.urlRegular,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress == null) return child;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              );
            },
            errorBuilder: (BuildContext context, Object exception,
                StackTrace? stackTrace) {
              return Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    'Couldn\'t load the picture',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 17),
                  ));
            },
          ),
          SizedBox(
            width: double.infinity,
            height: 2,
            child: DecoratedBox(
              decoration: BoxDecoration(color: Colors.grey),
            ),
          ),
          TitleStrap('AUTHOR'),
          UserView(widget._currentImage.user),
          if (widget._currentImage.description != null)
            TitleStrap('DESCRIPTION'),
          if (widget._currentImage.description != null)
            StyledText(widget._currentImage.description.toString()),
          if (widget._currentImage.likes != null) TitleStrap('NUMBER OF LIKES'),
          if (widget._currentImage.likes != null)
            StyledText(widget._currentImage.likes.toString()),
          if (widget._currentImage.createdDate != null)
            TitleStrap('CREATED DATE'),
          if (widget._currentImage.createdDate != null)
            StyledText(
                widget._currentImage.createdDate.toString().substring(0, 10)),
          if (widget._currentImage.updatedDate != null)
            TitleStrap('UPDATED DATE'),
          if (widget._currentImage.updatedDate != null)
            StyledText(
                widget._currentImage.updatedDate.toString().substring(0, 10)),
          if (widget._currentImage.width != null &&
              widget._currentImage.height != null)
            TitleStrap('ORIGINAL DIMENSIONS'),
          if (widget._currentImage.createdDate != null)
            StyledText(widget._currentImage.width.toString() +
                ' x ' +
                widget._currentImage.height.toString()),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final showFloatingButton =
        ModalRoute.of(context)!.settings.arguments as bool;
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50),
          child: MyAppBar(widget._currentImage.title)),
      body: FutureBuilder(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return buildDetails();
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: Visibility(
        child: FloatingActionButton(
          onPressed: () => addToFavourites(context),
          child: favourite ? Icon(Icons.favorite) : Icon(Icons.favorite_border),
          backgroundColor: Theme.of(context).dividerColor,
          foregroundColor: Theme.of(context).accentColor,
        ),
        visible: showFloatingButton,
      ),
    );
  }
}

class TitleStrap extends StatelessWidget {
  final String title;
  TitleStrap(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.cyan[400],
      margin: EdgeInsets.symmetric(vertical: 5),
      padding: EdgeInsets.all(5),
      width: double.infinity,
      height: 33,
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class StyledText extends StatelessWidget {
  final String title;
  StyledText(this.title);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 3.0),
      child: Center(
        child: Text(
          title,
          style: TextStyle(fontSize: 16),
          textAlign: TextAlign.justify,
        ),
      ),
    );
  }
}
