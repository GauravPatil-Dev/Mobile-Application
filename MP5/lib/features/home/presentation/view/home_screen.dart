import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/repos/home_repo_impl.dart';
import '../manager/breaking_news_cubit/breaking_news_cubit.dart';
import '../manager/recommended_news_cubit/recommended_news_cubit.dart';
import 'widgets/home_widgets.dart';

class HomeScreen extends StatelessWidget {
  final HomeRepoImpl homeRepoImpl;
  const HomeScreen(this.homeRepoImpl);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) =>
              BreakingNewsCubit(homeRepoImpl)..fetchBreakingNews(),
        ),
        BlocProvider(
          create: (BuildContext context) =>
              RecommendedNewsCubit(homeRepoImpl)..fetchRecommendedNews(),
        ),
      ],
      child: SafeArea(
        child: BlocBuilder<BreakingNewsCubit, BreakingNewsState>(
            builder: (context, state) {
          return BlocBuilder<RecommendedNewsCubit, RecommendedNewsState>(
              builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                context.read<BreakingNewsCubit>().fetchBreakingNews();
                context.read<RecommendedNewsCubit>().fetchRecommendedNews();
              },
              child: CustomScrollView(
                physics: const BouncingScrollPhysics(),
                slivers: [
                  SliverPersistentHeader(
                    pinned: true,
                    floating: true,
                    delegate: PersistentHeader(),
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: const [
                        TitleBar(
                          title: 'Breaking News',
                        ),
                        BreakingSlider(),
                        TitleBar(
                          title: 'Recommendation',
                        ),
                      ],
                    ),
                  ),
                  const SliverFillRemaining(
                    child: RecNewsListView(),
                  ),
                ],
              ),
            );
          });
        }),
      ),
    );
  }
}

class PersistentHeader extends SliverPersistentHeaderDelegate {
  PersistentHeader();

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return HomeAppBar();
  }

  @override
  double get maxExtent => 72.0;

  @override
  double get minExtent => 72.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
