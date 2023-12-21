import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:mp5/features/bookmark/presentation/manager/bookmark_cubit/bookmark_cubit.dart'; // Update this path
import 'package:mp5/features/home/data/models/news_model/news_model.dart'; // Update this path

// Create a Mock for SharedPreferences
class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  group('BookmarkCubit Tests', () {
    late BookmarkCubit bookmarkCubit;
    late MockSharedPreferences mockSharedPreferences;
    late NewsModel dummyNewsModel;

    setUp(() {
      SharedPreferences.setMockInitialValues({});
      mockSharedPreferences = MockSharedPreferences();
      when(mockSharedPreferences.getStringList('1'))
          .thenReturn(null); // Simulate initial empty state
      bookmarkCubit = BookmarkCubit();

      // Set up a dummy NewsModel
      dummyNewsModel = NewsModel(/* ... */); // Initialize with test data
    });

    test('initial state is HomeInitial', () {
      expect(bookmarkCubit.state, HomeInitial());
    });

    test('adds a news item to bookmarks', () async {
      bookmarkCubit.addToBookmarked(dummyNewsModel);
      await Future.delayed(Duration.zero); // Allow async operations to complete

      // Verify that SharedPreferences was used to save the bookmarked news

      // Check if state is updated correctly
      expect(bookmarkCubit.state, isA<AddToBookMarkedState>());
    });

    test('removes a news item from bookmarks', () async {
      bookmarkCubit.removeNewsModelFromLocal(dummyNewsModel);
      await Future.delayed(Duration.zero); // Allow async operations to complete

      // Verify that SharedPreferences was used to update the bookmarked news

      // Check if state is updated correctly
      expect(bookmarkCubit.state, isA<RemoveBookMarkedState>());
    });

    // Additional tests can be written for other methods and states
  });
}
