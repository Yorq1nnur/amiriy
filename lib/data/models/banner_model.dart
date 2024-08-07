class BannerModel {
  final String bannerTitle;
  final String bannerImageUrl;
  final String bannerOnTapUrl;
  final String bannerCreatedAt;

  BannerModel({
    required this.bannerTitle,
    required this.bannerImageUrl,
    required this.bannerOnTapUrl,
    required this.bannerCreatedAt,
  });

  factory BannerModel.fromJson(Map<String, dynamic> json) => BannerModel(
        bannerTitle: json[BannerModelFields.bannerTitle] as String? ?? '',
        bannerImageUrl: json[BannerModelFields.bannerImageUrl] as String? ?? '',
        bannerOnTapUrl: json[BannerModelFields.bannerOnTapUrl] as String? ?? '',
        bannerCreatedAt:
            json[BannerModelFields.bannerCreatedAt] as String? ?? '',
      );

  static  List<BannerModel> initialValue() => [
        BannerModel(
          bannerTitle: '',
          bannerImageUrl: '',
          bannerOnTapUrl: '',
          bannerCreatedAt: '',
        ),
      ];
}

class BannerModelFields {
  static const String bannerTitle = 'banner_title';
  static const String bannerImageUrl = 'banner_image_url';
  static const String bannerOnTapUrl = 'banner_url';
  static const String bannerCreatedAt = 'banner_created_at';
}
