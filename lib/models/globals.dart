class Globals {
  static var downloadedData;
  static var inputText;

  static saveScreen(List<dynamic> newData, String newText) {
    downloadedData = newData;
    inputText = newText;
  }

  List<dynamic> get getData {
    return downloadedData;
  }

  String get getInput {
    return inputText;
  }
}
