import 'package:amiriy/data/models/network_response.dart';
import 'package:amiriy/data/models/user_model.dart';
import 'package:amiriy/utils/constants/app_constants.dart';
import 'package:amiriy/utils/utility_functions/utility_functions.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class UserRepo {
  Future<NetworkResponse> addUser(UserModel userModel) async {
    try {
      DocumentReference documentReference = await FirebaseFirestore.instance
          .collection(AppConstants.users)
          .add(userModel.toJson());

      await FirebaseFirestore.instance
          .collection(AppConstants.users)
          .doc(documentReference.id)
          .update(
        {
          "userId": documentReference.id,
        },
      );
//"authUid": FirebaseAuth.instance.currentUser!.uid,
      return NetworkResponse(data: documentReference);
    } on FirebaseException catch (e) {
      return NetworkResponse(
        errorText: e.toString(),
      );
    }
  }

  Future<NetworkResponse> updateUser(UserModel userModel) async {
    try {
      UtilityFunctions.methodPrint(
        'ON UPDATE USER REPO ID IS: ${userModel.userId}\n ON UPDATE USER REPO IMAGE IS: ${userModel.imageUrl}',
      );
      await FirebaseFirestore.instance
          .collection(AppConstants.users)
          .doc(userModel.userId)
          .update(
            userModel.toJsonForUpdate(),
          );
      return NetworkResponse(
        data: 'updated successfully',
      );
    } on FirebaseException catch (e) {
      return NetworkResponse(
        errorText: e.toString(),
      );
    }
  }

  Future<NetworkResponse> getUser(String userId) async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection(AppConstants.users)
          .where("authUid", isEqualTo: userId)
          .get();

      List<UserModel> users = querySnapshot.docs
          .map(
            (e) => UserModel.fromJson(
              e.data() as Map<String, dynamic>,
            ),
          )
          .toList();

      return NetworkResponse(
        data: users.isEmpty ? UserModel.initial() : users[0],
      );
    } on FirebaseException catch (e) {
      return NetworkResponse(
        errorText: e.toString(),
      );
    }
  }
}
