class UserModel {
  final String username;
  final String phoneNumber;
  final String userId;
  final String authUid;
  final String password;
  final String imageUrl;

  UserModel({
    required this.phoneNumber,
    required this.userId,
    required this.username,
    required this.authUid,
    required this.password,
    required this.imageUrl,
  });

  UserModel copyWith({
    String? username,
    String? phoneNumber,
    String? userId,
    String? authUid,
    String? password,
    String? imageUrl,
  }) {
    return UserModel(
      userId: userId ?? this.userId,
      username: username ?? this.username,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      authUid: authUid ?? this.authUid,
      password: password ?? this.password,
      imageUrl: imageUrl ?? this.imageUrl,
    );
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "username": username,
        "phoneNumber": phoneNumber,
        "authUid": authUid,
        "image_url": imageUrl,
      };

  Map<String, dynamic> toJsonForUpdate() => {
        "username": username,
        "phoneNumber": phoneNumber,
        "image_url": imageUrl,
      };

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      phoneNumber: json["phoneNumber"] as String? ?? "",
      userId: json["userId"] as String? ?? "",
      username: json["username"] as String? ?? "",
      authUid: json["authUid"] as String? ?? "",
      password: json["password"] as String? ?? "",
      imageUrl: json["image_url"] as String? ?? "",
    );
  }

  static UserModel initial() => UserModel(
        phoneNumber: "",
        userId: "",
        username: "",
        authUid: "",
        password: '',
        imageUrl: '',
      );
}
