import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../models/my_image.dart';
import '../models/user.dart';

class DatabaseHelper {
  static final _dbName = 'Database.db';
  static final _dbVersion = 1;
  static final _tableName = 'favourites';

  static final columnId = '_id';
  static final columnUnsplashId = 'unsplashId';
  static final columnTitle = 'title';
  static final columnSmallUrl = 'urlSmall';
  static final columnRegularUrl = 'urlRegular';
  static final columnDescription = 'description';
  static final columnCreatedDate = 'createdDate';
  static final columnUpdatedDate = 'updatedDate';
  static final columnWidth = 'width';
  static final columnHeight = 'height';
  static final columnLikes = 'likes';
  static final columnUserName = 'userName';
  static final columnUserImage = 'userImage';
  static final columnUserPortfolio = 'userPortfolio';
  static final columnUserInstagram = 'userInstagram';
  static final columnUserTwitter = 'userTwitter';

  DatabaseHelper._privateConstuctor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstuctor();

  static Database? _database;
  Future<Database> get database async =>
      _database ??= await _initiateDatabase();

  Future<Database> _initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, _dbName);
    return await openDatabase(path, version: _dbVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(''' 
          CREATE TABLE $_tableName ( 
          $columnId INTEGER PRIMARY KEY,
          $columnUnsplashId TEXT,
          $columnTitle TEXT,
          $columnSmallUrl TEXT,
          $columnRegularUrl TEXT,
          $columnDescription TEXT,
          $columnCreatedDate TEXT,
          $columnUpdatedDate TEXT,
          $columnWidth TEXT,
          $columnHeight TEXT,
          $columnLikes TEXT,
          $columnUserName TEXT,
          $columnUserImage TEXT,
          $columnUserPortfolio TEXT,
          $columnUserInstagram TEXT,
          $columnUserTwitter TEXT)
          ''');
  }

  Future insert(MyImage myImage) async {
    Map<String, dynamic> row = {
      columnUnsplashId: myImage.id,
      columnTitle: myImage.title,
      columnSmallUrl: myImage.urlSmall,
      columnRegularUrl: myImage.urlRegular,
      columnDescription: myImage.description,
      columnCreatedDate: myImage.createdDate,
      columnUpdatedDate: myImage.updatedDate,
      columnWidth: myImage.width,
      columnHeight: myImage.height,
      columnLikes: myImage.likes,
      columnUserName: myImage.user.name,
      columnUserImage: myImage.user.image,
      columnUserInstagram: myImage.user.instagram,
      columnUserTwitter: myImage.user.twitter,
    };
    Database db = await instance.database;
    await db.insert(_tableName, row);
  }

  Future<List<MyImage>> getImages() async {
    final db = await database;
    List<Map> result = await db.rawQuery("SELECT * FROM $_tableName");
    List<MyImage> images = [];
    result.forEach((result) {
      var user = User(
        name: result[columnUserName],
        image: result[columnUserImage],
        instagram: result[columnUserInstagram],
        twitter: result[columnUserTwitter],
      );
      var image = MyImage(
          id: result[columnUnsplashId],
          title: result[columnTitle],
          urlSmall: result[columnSmallUrl],
          urlRegular: result[columnSmallUrl],
          description: result[columnDescription],
          createdDate: result[columnCreatedDate],
          updatedDate: result[columnUpdatedDate],
          width: result[columnWidth],
          height: result[columnHeight],
          likes: result[columnLikes],
          user: user);
      images.add(image);
    });
    return images;
  }

  Future<int> delete(String id) async {
    final db = await instance.database;
    return await db
        .delete(_tableName, where: '$columnUnsplashId = ?', whereArgs: [id]);
  }

  Future<bool> checkIfExists(MyImage image) async {
    final db = await database;
    List<Map> result = await db.rawQuery(
        "SELECT * FROM $_tableName WHERE $columnUnsplashId LIKE ?", [image.id]);
    return result.isNotEmpty;
  }
}
