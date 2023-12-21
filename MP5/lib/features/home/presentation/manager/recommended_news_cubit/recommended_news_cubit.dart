import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/models.dart';
import '../../../data/repos/home_repo.dart';

part 'recommended_news_state.dart';

class RecommendedNewsCubit extends Cubit<RecommendedNewsState> {
  RecommendedNewsCubit(this.homeRepo) : super(RecommendedNewsInitial());
  final HomeRepo homeRepo;

  Future<void> fetchRecommendedNews() async {
    emit(RecommendedNewsLoadingState());
    try {
      List<NewsModel> news = await homeRepo.fetchRecommendedNews();
      emit(RecommendedNewsSuccessState(news));
    } catch (e) {
      if (e is Failure) {
        emit(RecommendedNewsFailureState(e.errMessage));
      } else {
        // Handle unexpected errors
        emit(RecommendedNewsFailureState('Unexpected error occurred'));
      }
    }
  }
}
