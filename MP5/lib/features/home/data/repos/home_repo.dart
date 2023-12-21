import '../../../../core/errors/failures.dart';
import '../models/news_model/news_model.dart';

abstract class HomeRepo {
  Future<List<NewsModel>> fetchBreakingNews();
  Future<List<NewsModel>> fetchRecommendedNews();
  Future<List<NewsModel>> search({required String value});
}
