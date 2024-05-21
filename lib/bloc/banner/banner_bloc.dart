import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/models/network_response.dart';
import 'package:amiriy/data/repositories/banner_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'banner_event.dart';
import 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc({required this.bannerRepository})
      : super(BannerState.initialValue()) {
    on<GetBannerEvent>(_getBanner);
  }

  final BannerRepository bannerRepository;

  _getBanner(GetBannerEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.loading));
    NetworkResponse networkResponse = await bannerRepository.getBanner();
    if (networkResponse.errorText.isEmpty) {
      emit(state.copyWith(
        status: FormStatus.success,
        banners: networkResponse.data,
      ));
    } else {
      emit(state.copyWith(
        status: FormStatus.error,
        errorMessage: networkResponse.errorText,
      ));
    }
  }
}
