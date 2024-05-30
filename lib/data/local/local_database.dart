// ignore: depend_on_referenced_packages
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import '../models/network_response.dart';
import '../models/notification_model.dart';

class LocalDatabase {
  static final databaseInstance = LocalDatabase._();

  LocalDatabase._();

  factory LocalDatabase() {
    return databaseInstance;
  }

  Database? _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database!;
    } else {
      _database = await _init("notification.db");
      return _database!;
    }
  }

  Future<Database> _init(String databaseName) async {
    String internalPath = await getDatabasesPath();
    String path = join(internalPath, databaseName);
    return await openDatabase(
      path,
      version: 2,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    const idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    const textType = 'TEXT NOT NULL';
    const boolType = 'INTEGER NOT NULL DEFAULT 0';

    await db.execute('''
      CREATE TABLE ${NotificationModelConstants.tableName} (
        ${NotificationModelConstants.id} $idType,
        ${NotificationModelConstants.title} $textType,
        ${NotificationModelConstants.description} $textType,
        ${NotificationModelConstants.image} $textType,
        ${NotificationModelConstants.dateTime} $textType,
        ${NotificationModelConstants.isRead} $boolType
      )
    ''');
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      await db.execute(
          'ALTER TABLE ${NotificationModelConstants.tableName} ADD COLUMN ${NotificationModelConstants.isRead} INTEGER NOT NULL DEFAULT 0');
    }
  }

  static Future<NotificationModel> insertNotification(
      NotificationModel notificationModel) async {
    try {
      final db = await databaseInstance.database;
      int savedTaskId = await db.insert(
          NotificationModelConstants.tableName, notificationModel.toJson());
      debugPrint("saved id:$savedTaskId");
      return notificationModel.copyWith(id: savedTaskId);
    } catch (error) {
      debugPrint("Error inserting notification: $error");
      rethrow; // Optionally, handle the error or rethrow it
    }
  }

  static Future<NetworkResponse> getAllNotification() async {
    NetworkResponse networkResponse = NetworkResponse();

    try {
      final db = await databaseInstance.database;
      String orderBy = "${NotificationModelConstants.id} DESC";
      List<Map<String, dynamic>> json = await db
          .query(NotificationModelConstants.tableName, orderBy: orderBy);
      networkResponse.data =
          json.map((e) => NotificationModel.fromJson(e)).toList();
    } catch (error) {
      networkResponse.errorText = error.toString();
    }

    return networkResponse;
  }

  static Future<int> deleteNotification(int id) async {
    final db = await databaseInstance.database;
    int deletedId = await db.delete(
      NotificationModelConstants.tableName,
      where: "${NotificationModelConstants.id} = ?",
      whereArgs: [id],
    );
    return deletedId;
  }

  static Future<int> updateNotification(
      NotificationModel notificationModel, int id) async {
    final db = await databaseInstance.database;
    int updatedId = await db.update(
      NotificationModelConstants.tableName,
      notificationModel.toJson(),
      where: "${NotificationModelConstants.id} = ?",
      whereArgs: [id],
    );

    return updatedId;
  }

  static Future<List<NotificationModel>> searchNotification(
      String query) async {
    final db = await databaseInstance.database;
    var json = await db.query(NotificationModelConstants.tableName,
        where: "${NotificationModelConstants.title} LIKE ?",
        whereArgs: ["$query%"]);
    return json.map((e) => NotificationModel.fromJson(e)).toList();
  }

  static Future<int> markAsRead(int id) async {
    final db = await databaseInstance.database;
    return await db.update(
      NotificationModelConstants.tableName,
      {NotificationModelConstants.isRead: 1},
      where: '${NotificationModelConstants.id} = ?',
      whereArgs: [id],
    );
  }

  static Future<int> markAsUnread(int id) async {
    final db = await databaseInstance.database;
    return await db.update(
      NotificationModelConstants.tableName,
      {NotificationModelConstants.isRead: 0},
      where: '${NotificationModelConstants.id} = ?',
      whereArgs: [id],
    );
  }

  static Future<List<NotificationModel>> getUnreadNotifications() async {
    final db = await databaseInstance.database;
    var json = await db.query(
      NotificationModelConstants.tableName,
      where: '${NotificationModelConstants.isRead} = 0',
      orderBy: '${NotificationModelConstants.dateTime} DESC',
    );
    return json.map((e) => NotificationModel.fromJson(e)).toList();
  }

  static Future<List<NotificationModel>> getReadNotifications() async {
    final db = await databaseInstance.database;
    var json = await db.query(
      NotificationModelConstants.tableName,
      where: '${NotificationModelConstants.isRead} = 1',
      orderBy: '${NotificationModelConstants.dateTime} DESC',
    );
    return json.map((e) => NotificationModel.fromJson(e)).toList();
  }

  static Future<void> toggleNotificationReadStatus(int id, bool isRead) async {
    final db = await databaseInstance.database;
    int updatedRows = await db.update(
      NotificationModelConstants.tableName,
      {NotificationModelConstants.isRead: isRead ? 1 : 0},
      where: '${NotificationModelConstants.id} = ?',
      whereArgs: [id],
    );

    if (updatedRows > 0) {
      debugPrint('Notification read status updated successfully');
    } else {
      debugPrint('Failed to update notification read status');
    }
  }
}

class NotificationModelConstants {
  static const String tableName = 'Notifications';
  static const String title = 'title';
  static const String description = 'description';
  static const String image = 'image';
  static const String dateTime = 'dateTime';
  static const String id = '_id';
  static const String isRead = 'isRead';
}
