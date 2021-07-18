import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../widgets/images_list.dart';
import '../models/saved_list.dart';
import '../bloc/images_bloc.dart';

class SearchBody extends StatefulWidget {
  @override
  _SearchBodyState createState() => _SearchBodyState();
}

class _SearchBodyState extends State<SearchBody> {
  final TextEditingController _controller = TextEditingController();

  void loadData(ImagesBloc imagesBloc) {
    FocusScope.of(context).unfocus();
    imagesBloc.add(FetchImages(_controller.text));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildButton(ImagesBloc imagesBloc) {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).accentColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ))),
      onPressed: () => loadData(imagesBloc),
      child: Text(
        'Submit',
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final imagesBloc = BlocProvider.of<ImagesBloc>(context);
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(10, 5, 10, 10),
          child: Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: InputDecoration(hintText: 'Search for a photo'),
                  style: TextStyle(fontSize: 17),
                  controller: _controller,
                  textInputAction: TextInputAction.search,
                  onEditingComplete: () => loadData(imagesBloc),
                ),
              ),
              SizedBox(width: 10),
              buildButton(imagesBloc),
            ],
          ),
        ),
        BlocBuilder<ImagesBloc, ImagesState>(
          builder: (context, state) {
            if (state is ImagesAreNotSearched)
              return Expanded(child: ImagesList(SavedList.downloadedData));
            else if (state is ImagesAreLoading)
              return Center(child: CircularProgressIndicator());
            else if (state is ImagesAreLoaded) {
              SavedList.saveScreen(state.getData);
              if (state.getData.isEmpty) {
                return Text('No pictures found.',
                    style: TextStyle(fontSize: 15));
              }
              return Expanded(child: ImagesList(state.getData));
            }
            return Text(
              'An error has occurred.\nCheck your internet connection.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 15),
            );
          },
        ),
      ],
    );
  }
}
