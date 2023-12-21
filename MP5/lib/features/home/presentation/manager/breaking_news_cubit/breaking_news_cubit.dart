import 'package:carousel_slider/carousel_controller.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';

import '../../../data/models/news_model/news_model.dart';
import '../../../data/repos/home_repo.dart';

part 'breaking_news_state.dart';

class BreakingNewsCubit extends Cubit<BreakingNewsState> {
  BreakingNewsCubit(this.homeRepo) : super(BreakingNewsInitial());
  final HomeRepo homeRepo;
  int current = 0;
  final CarouselController carouselController = CarouselController();

  Future<void> fetchBreakingNews() async {
    emit(BreakingNewsLoadingState());
    try {
      List<NewsModel> news =
          (await homeRepo.fetchBreakingNews()) as List<NewsModel>;
      emit(BreakingNewsSuccessState(news));
    } catch (e) {
      if (e is Failure) {
        emit(BreakingNewsFailureState(e.errMessage));
      } else {
        // Handle unexpected errors
        emit(BreakingNewsFailureState('Unexpected error occurred'));
      }
    }
  }
}
