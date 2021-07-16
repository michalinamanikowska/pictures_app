import 'package:flutter/material.dart';

class MyAppBar extends StatelessWidget {
  final String title;
  MyAppBar(this.title);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      title: Text(title.toUpperCase(),
          style: TextStyle(
              fontWeight: FontWeight.w800, fontSize: 20, color: Colors.white)),
      backgroundColor: Theme.of(context).dividerColor,
      shadowColor: Colors.grey,
      iconTheme: IconThemeData(
        color: Theme.of(context).accentColor,
      ),
    );
  }
}
