import 'package:amiriy/data/models/banner_model.dart';
import 'package:amiriy/data/models/network_response.dart';
import 'package:amiriy/utils/constants/app_constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class BannerRepository {
  Future<NetworkResponse> getBanner() async {
    List<BannerModel> banners = [];
    try {
      await FirebaseFirestore.instance
          .collection(AppConstants.banners)
          .get()
          .then((snapshot) {
        banners =
            snapshot.docs.map((e) => BannerModel.fromJson(e.data())).toList();
      });
      if (banners.isNotEmpty) {
        return NetworkResponse(
          data: banners,
        );
      } else {
        return NetworkResponse(errorText: "No Data");
      }
    } on FirebaseException catch (e) {
      return NetworkResponse(errorText: "Firestore error: ${e.message}");
    } catch (e) {
      return NetworkResponse(errorText: e.toString());
    }
  }
}
