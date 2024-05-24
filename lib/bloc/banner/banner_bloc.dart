import 'package:amiriy/bloc/form_status/form_status.dart';
import 'package:amiriy/data/models/banner_model.dart';
import 'package:amiriy/data/repositories/banner_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'banner_event.dart';
import 'banner_state.dart';

class BannerBloc extends Bloc<BannerEvent, BannerState> {
  BannerBloc({required this.bannerRepository})
      : super(BannerState.initialValue()) {
    // on<GetBannerEvent>(_getBanner);
    on<GetBannerEvent>(_listenBanner);
  }

  final BannerRepository bannerRepository;

  _listenBanner(GetBannerEvent event, Emitter emit) async {
    emit(state.copyWith(status: FormStatus.loading));

    await emit.onEach(bannerRepository.getBannerStream(),
        onData: (List<BannerModel> bannersStream) {
      emit(
        state.copyWith(
          status: FormStatus.success,
          banners: bannersStream,
        ),
      );
    }, onError: (e, s) {
      emit(
        state.copyWith(
          status: FormStatus.error,
          errorMessage: e.toString(),
        ),
      );
    });
  }

  // _getBanner(GetBannerEvent event, Emitter emit) async {
  //   emit(state.copyWith(status: FormStatus.loading));
  //   NetworkResponse networkResponse = await bannerRepository.getBanner();
  //   if (networkResponse.errorText.isEmpty) {
  //     emit(state.copyWith(
  //       status: FormStatus.success,
  //       banners: networkResponse.data,
  //     ));
  //   } else {
  //     emit(state.copyWith(
  //       status: FormStatus.error,
  //       errorMessage: networkResponse.errorText,
  //     ));
  //   }
  // }
}

//banner_url
//banner_title
//banner_image_url
//banner_created_at
//https://t.me/kokandakm/14724?single