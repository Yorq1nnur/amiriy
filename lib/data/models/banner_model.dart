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
        bannerTitle: json['banner_title'] as String? ?? '',
        bannerImageUrl: json['banner_image_url'] as String? ?? '',
        bannerOnTapUrl: json['banner_url'] as String? ?? '',
        bannerCreatedAt: json['banner_created_at'] as String? ?? '',
      );

  static List<BannerModel> initialValue() => [
        BannerModel(
          bannerTitle: '',
          bannerImageUrl: '',
          bannerOnTapUrl: '',
          bannerCreatedAt: '',
        ),
      ];
}
