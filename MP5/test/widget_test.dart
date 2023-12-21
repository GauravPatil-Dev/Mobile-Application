import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mp5/features/bookmark/presentation/manager/bookmark_cubit/bookmark_cubit.dart';
import 'package:mp5/features/bookmark/presentation/view/bookmark_screen.dart';

// Mock the BookmarkCubit
class MockBookmarkCubit extends Mock implements BookmarkCubit {}

void main() {
  group('BookmarkScreen Tests', () {
    // Create a mock instance of BookmarkCubit
    late MockBookmarkCubit mockBookmarkCubit;

    setUp(() {
      mockBookmarkCubit = MockBookmarkCubit();
    });

    Widget createTestableWidget(Widget child) {
      return MaterialApp(
        home: BlocProvider<BookmarkCubit>(
          create: (context) => mockBookmarkCubit,
          child: child,
        ),
      );
    }

    testWidgets('displays empty state when there are no bookmarks',
        (tester) async {
      // Arrange
      when(mockBookmarkCubit.bookmarkedNews).thenReturn([]);

      // Act
      await tester.pumpWidget(createTestableWidget(const BookmarkScreen()));
      await tester.pump(); // Rebuild the widget after the state has changed.

      // Assert
      expect(find.text('No Bookmarked News'), findsOneWidget);
      expect(find.byType(Icon), findsOneWidget);
    });

    // Add more tests to check for different states and interactions
  });
}
