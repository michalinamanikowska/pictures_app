class SavedList {
  static var downloadedData = [];

  static saveScreen(List<dynamic> newData) {
    downloadedData = newData;
  }

  List<dynamic> get getData {
    return downloadedData;
  }
}
