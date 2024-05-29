import 'package:amiriy/data/models/audio_books_model.dart';
import 'package:amiriy/data/models/network_response.dart';
import 'package:amiriy/utils/constants/app_constants.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SavedAudioDb {
  static final SavedAudioDb instance = SavedAudioDb._init();

  static Database? _database;

  SavedAudioDb._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB(AppConstants.savedAudioDb);
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    const productTable = '''
    CREATE TABLE ${AppConstants.savedAudio} (
      ${AudioBooksFields.id} INTEGER PRIMARY KEY,
      ${AudioBooksFields.bookName} TEXT NOT NULL,
      ${AudioBooksFields.bookUrl} TEXT NOT NULL,
      ${AudioBooksFields.imageUrl} TEXT NOT NULL,
      ${AudioBooksFields.bookAuthor} TEXT NOT NULL
    )
    ''';

    await db.execute(productTable);
  }

  Future<NetworkResponse> insertProduct(AudioBooksModel audioBookModel) async {
    final db = await instance.database;

    // Check if the audio book already exists in the database
    final result = await db.query(
      AppConstants.savedAudio,
      where: 'book_name = ?',
      whereArgs: [audioBookModel.bookName],
    );

    if (result.isEmpty) {
      try {
        // Insert the new audio book
        await db.insert(
          AppConstants.savedAudio,
          audioBookModel.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
        UtilityFunctions.methodPrint(
          'PRODUCT ADDED SUCCESSFULLY TO DB!!! PRODUCT NAME: ${audioBookModel.bookName}',
        );
        return NetworkResponse(data: 'success');
      } catch (e) {
        UtilityFunctions.methodPrint(
          'NOT ADDED TO DB, BECAUSE: $e',
        );
        return NetworkResponse(
          errorText: e.toString(),
        );
      }
    } else {
      UtilityFunctions.methodPrint(
        'PRODUCT ALREADY EXISTS IN DB!!! PRODUCT NAME: ${audioBookModel.bookName}',
      );
      return NetworkResponse(
        errorText: 'Product already exists in the database',
      );
    }
  }

  Future<AudioBooksModel?> fetchProduct(String productName) async {
    final db = await instance.database;
    final maps = await db.query(
      AppConstants.savedAudio,
      columns: AudioBooksFields.values,
      where: '${AudioBooksFields.bookName} = ?',
      whereArgs: [productName],
    );

    if (maps.isNotEmpty) {
      return AudioBooksModel.fromJson(maps.first);
    } else {
      return null;
    }
  }

  Stream<List<AudioBooksModel>> listenLatestProducts() async* {
    try {
      final db = await instance.database;
      final result = await db.query(AppConstants.savedAudio);

      List<AudioBooksModel> products =
          result.map((json) => AudioBooksModel.fromJson(json)).toList();

      UtilityFunctions.methodPrint(
        'GET PRODUCTS FROM DB, PRODUCTS LENGTH IS: ${products.length}',
      );

      yield products;
    } catch (e) {
      UtilityFunctions.methodPrint(
        'ERROR GET PRODUCTS FROM DB, BECAUSE: $e',
      );
      yield [];
    }
  }

  Future<NetworkResponse> fetchAllProducts() async {
    try {
      final db = await instance.database;
      final result = await db.query(AppConstants.savedAudio);

      List<AudioBooksModel> products =
          result.map((json) => AudioBooksModel.fromJson(json)).toList();
      UtilityFunctions.methodPrint(
        'GET PRODUCTS FROM DB, PRODUCTS LENGTH IS: ${products.length}',
      );

      return NetworkResponse(
        data: products,
      );
    } catch (e) {
      UtilityFunctions.methodPrint(
        'ERROR GET PRODUCTS FROM DB, BECAUSE: $e',
      );
      return NetworkResponse(
        errorText: e.toString(),
      );
    }
  }

  Future<NetworkResponse> deleteProduct(int id) async {
    final db = await instance.database;
    try {
      await db.delete(
        AppConstants.savedAudio,
        where: '${AudioBooksFields.id} = ?',
        whereArgs: [id],
      );
      UtilityFunctions.methodPrint(
        'PRODUCT DELETED SUCCESSFULLY FROM DB!!! $id}',
      );
      return NetworkResponse(
        data: 'deleted',
      );
    } catch (e) {
      UtilityFunctions.methodPrint(
        'NOT DELETED PRODUCT FROM DB, BECAUSE: $e',
      );
      return NetworkResponse(
        errorText: e.toString(),
      );
    }
  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
