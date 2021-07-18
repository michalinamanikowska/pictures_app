import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bodies/favourites_body.dart';
import '../bodies/search_body.dart';
import '../widgets/app_bar.dart';
import '../bloc/images_bloc.dart';
import '../repositories/images_repository.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(50), child: MyAppBar('Pictures App')),
      body: GestureDetector(
          child: _selectedPageIndex == 0
              ? BlocProvider(
                  create: (context) => ImagesBloc(ImagesRepository()),
                  child: SearchBody(),
                )
              : FavouritesBody(),
          onPanUpdate: (details) {
            if ((details.delta.dx < 0 && _selectedPageIndex == 0) ||
                details.delta.dx > 0 && _selectedPageIndex == 1) {
              setState(() {
                _selectedPageIndex = 1 - _selectedPageIndex;
              });
            }
          }),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorites'),
        ],
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).dividerColor,
        selectedItemColor: Theme.of(context).accentColor,
        unselectedItemColor: Theme.of(context).backgroundColor,
        selectedFontSize: 13,
        unselectedFontSize: 13,
        onTap: (newIndex) => setState(() {
          _selectedPageIndex = newIndex;
        }),
      ),
    );
  }
}
