import '../../../../constants.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/utils/api_service.dart';
import '../models/news_model/news_model.dart';
import 'home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService = ApiService();

  HomeRepoImpl();
  @override
  Future<List<NewsModel>> fetchBreakingNews() async {
    try {
      Map<String, dynamic> data = await apiService.get(
        endPoint: 'top-headlines',
        queryParameters: {
          'country': 'us',
          'page': '1',
          'pageSize': '4',
          'apiKey': AppConstants.apiKey,
        },
      );
      List<NewsModel> breakingNews = [];
      for (var article in data['articles']) {
        breakingNews.add(NewsModel.fromJson(article));
      }
      return breakingNews;
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  @override
  Future<List<NewsModel>> fetchRecommendedNews() async {
    try {
      Map<String, dynamic> data = await apiService.get(
        endPoint: 'everything',
        queryParameters: {
          'q': 'recommended',
          'page': '1',
          'pageSize': '10',
          'apiKey': AppConstants.apiKey,
        },
      );
      List<NewsModel> recommendedNews = [];
      for (var article in data['articles']) {
        recommendedNews.add(NewsModel.fromJson(article));
      }
      return recommendedNews;
    } catch (e) {
      throw ServerFailure(e.toString());
      ;
    }
  }

  @override
  Future<List<NewsModel>> search({required String value}) async {
    try {
      Map<String, dynamic> data = await apiService.get(
        endPoint: 'everything',
        queryParameters: {
          'q': value,
          'page': '1',
          'pageSize': '10',
          'apiKey': AppConstants.apiKey,
        },
      );
      List<NewsModel> searchResult = [];
      for (var article in data['articles']) {
        searchResult.add(NewsModel.fromJson(article));
      }
      return searchResult;
    } catch (e) {
      throw ServerFailure(e.toString());
      ;
    }
  }
}
