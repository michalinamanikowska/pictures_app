import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../widgets/images_list.dart';
import '../models/globals.dart';
import 'package:http/http.dart' as http;

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _controller = TextEditingController();
  String searchValue = '';
  bool isLoading = false;
  List downloadedData = [];

  Future<void> getData(ctx) async {
    searchValue = _controller.text;
    FocusScope.of(context).unfocus();
    setState(() {
      isLoading = true;
    });
    final url = Uri.parse(
        'https://api.unsplash.com/search/photos?per_page=30&query=$searchValue&client_id=djkF0imZLQieLADtwAEz1_7xeOXFFv5P5appQEHgvkQ');
    try {
      var response = await http.get(url);
      var data = json.decode(response.body);
      setState(() {
        downloadedData = data['results'];
        isLoading = false;
        if (downloadedData.isEmpty) {
          ScaffoldMessenger.of(ctx).showSnackBar(
            SnackBar(
              content: Text('No pictures found.'),
            ),
          );
        }
        Globals.saveScreen(downloadedData, _controller.text);
      });
    } catch (error) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        SnackBar(
          content:
              Text('An error has occurred.\nCheck your internet connection.'),
          action: SnackBarAction(
            label: "Ok",
            onPressed: () => setState(() {
              isLoading = false;
            }),
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    if (Globals.inputText != null) {
      _controller.text = Globals.inputText;
      downloadedData = Globals.downloadedData;
    }
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Widget buildButton() {
    return ElevatedButton(
      style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all(Theme.of(context).accentColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ))),
      onPressed: () => getData(context),
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
                  onEditingComplete: () => getData(context),
                ),
              ),
              SizedBox(width: 10),
              buildButton(),
            ],
          ),
        ),
        isLoading
            ? Center(child: CircularProgressIndicator())
            : Expanded(child: ImagesList(downloadedData)),
      ],
    );
  }
}
