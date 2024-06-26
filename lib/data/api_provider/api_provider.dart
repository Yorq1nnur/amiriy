import 'dart:convert';
import 'dart:io';
import 'package:amiriy/data/models/book_model.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class ApiProvider {
  Future<String> sendNotificationToUsers({
    String? topicName,
    String? fcmToken,
    String? imageUrl,
    String? description,
    String? bookName,
    String? bookAuthor,
    String? bookPrice,
    String? bookRate,
    String? categoryDocId,
    required String title,
    required String body,
  }) async {
    try {
      http.Response response = await http.post(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          "Authorization":
              "key=AAAAsZso0wI:APA91bG9O_xDnwa4nvasGYhZ6ROsuakIEEVNT1Tb5aYwS5RvygemYfuSofWpku8Z3qRKBSXkERMJP2aMiLNTi2GPYZ7gPUEPG8-UgtoG9-4zsWJoe-b8fAXjSpwCyG0JVzMnIQVpcNER",
          "Content-Type": "application/json",
        },
        body: jsonEncode(
          {
            "to": topicName != null ? "/topics/$topicName" : fcmToken,
            "notification": {
              "title": title,
              "body": body,
              "sound": "default",
              "priority": "max"
            },
            "data": {
              "image_url": imageUrl ??
                  "https://top.uz/upload/iblock/0de/0dec725e4583a0698a8732ca646a4994.png",
              "book_name": bookName ?? "",
              "book_description": description ??
                  "Finland's national carrier Finnair has started weighing passengers on its flights from the capital city of Helsinki. The weigh-ins are being done on a voluntary basis and are completely anonymous. A company spokesperson said the new initiative is to ensure safety standards on flights are adhered to. He said any airplane should not exceed the prescribed maximum weight for safe take-offs and landings.",
              "author": bookAuthor ?? "",
              "rate": bookRate ?? "0.0",
              "price": bookPrice ?? "0",
              "category_doc_id": categoryDocId ?? ""
            }
          },
        ),
      );
      if (response.statusCode == HttpStatus.ok) {
        debugPrint("DATA:${response.body}");
        return response.body.toString();
      }
    } catch (err) {
      debugPrint(err.toString());
    }

    return "ERROR";
  }

  Future<Object> readNotification({
    String? topicName,
    String? fcmToken,
    String? imageUrl,
    String? description,
    String? bookName,
    String? bookAuthor,
    String? bookPrice,
    String? bookRate,
    String? categoryDocId,
    required String title,
    required String body,
  }) async {
    try {
      http.Response response = await http.get(
        Uri.parse("https://fcm.googleapis.com/fcm/send"),
        headers: {
          "Authorization":
              "key=AAAAsZso0wI:APA91bG9O_xDnwa4nvasGYhZ6ROsuakIEEVNT1Tb5aYwS5RvygemYfuSofWpku8Z3qRKBSXkERMJP2aMiLNTi2GPYZ7gPUEPG8-UgtoG9-4zsWJoe-b8fAXjSpwCyG0JVzMnIQVpcNER",
          "Content-Type": "application/json",
        },
      );
      if (response.statusCode == HttpStatus.ok) {
        debugPrint("DATA:${response.body}");
        return BookModel.fromJson(response.body as Map<String, dynamic>);
      }
    } catch (err) {
      debugPrint(err.toString());
    }

    return "ERROR";
  }
}
