import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/models/banner_model.dart';
import 'package:equatable/equatable.dart';

class BannerState extends Equatable {
  final List<BannerModel> banners;
  final FormStatus status;
  final String errorMessage;

  const BannerState({
    required this.banners,
    required this.status,
    required this.errorMessage,
  });

  BannerState copyWith({
    List<BannerModel>? banners,
    FormStatus? status,
    String? errorMessage,
  }) {
    return BannerState(
      banners: banners ?? this.banners,
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  static BannerState initialValue() => BannerState(
      banners: BannerModel.initialValue(),
      status: FormStatus.pure,
      errorMessage: '');

  @override
  List<Object?> get props => [
        banners,
        status,
        errorMessage,
      ];
}
