import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/errors/failures.dart';
import '../../../data/models/models.dart';
import '../../../data/repos/home_repo.dart';

part 'search_cubit_state.dart';

class SearchCubit extends Cubit<SearchState> {
  SearchCubit(this.homeRepo) : super(SearchCubitInitial());
  final HomeRepo homeRepo;

  Future<void> search(String value) async {
    emit(SearchLoadingState());
    try {
      List<NewsModel> news = await homeRepo.search(value: value);
      emit(SearchSuccessState(news));
    } catch (e) {
      if (e is Failure) {
        emit(SearchFailureState(e.errMessage));
      } else {
        // Handle unexpected errors
        emit(SearchFailureState('Unexpected error occurred'));
      }
    }
  }
}
