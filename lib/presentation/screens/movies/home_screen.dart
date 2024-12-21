import 'package:cinemapedia/presentation/providers/movies/initial_loading_prover.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_providers.dart';
import 'package:cinemapedia/presentation/providers/movies/movies_slideshow_provider.dart';
import 'package:cinemapedia/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinemapedia/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_appbar.dart';
import 'package:cinemapedia/presentation/widgets/shared/custom_botton_navigatonbar.dart';
import 'package:cinemapedia/presentation/widgets/shared/full_screen_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeScreen extends StatelessWidget {
  static const name = 'home-screen';
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: HomeView(),
      bottomNavigationBar: CustomBottonNavigation(),
    );
  }
}

class HomeView extends ConsumerStatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();
    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMovieProvider.notifier).loadNextPage();
    ref.read(upcomingMovieProvider.notifier).loadNextPage();
    ref.read(topRatedMovieProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingProvider);
    if (initialLoading) return const FullScreenLoader();

    final nowPlayinsMovies = ref.watch(nowPlayingMoviesProvider);
    final moviesSlideShow = ref.watch(moviesSlideShowProvider);
    final popularMoviesProvider = ref.watch(popularMovieProvider);
    final upcomingMoviesProvider = ref.watch(upcomingMovieProvider);
    final topRatedMoviesProvider = ref.watch(topRatedMovieProvider);

    if (moviesSlideShow.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title: CustomAppbar(),
          ),
        ),
        SliverList(
            delegate: SliverChildBuilderDelegate((context, index) {
          return Column(
            children: [
              MoviesSlideShow(movies: moviesSlideShow),
              MovieHorizontalListview(
                  movies: nowPlayinsMovies,
                  title: "En Cines",
                  subTitle: "Cinemax",
                  loadNextPage: () => ref
                      .read(nowPlayingMoviesProvider.notifier)
                      .loadNextPage()),
              MovieHorizontalListview(
                  movies: upcomingMoviesProvider,
                  title: "Proximamente",
                  subTitle: "Este Mes",
                  loadNextPage: () =>
                      ref.read(upcomingMovieProvider.notifier).loadNextPage()),
              MovieHorizontalListview(
                  movies: popularMoviesProvider,
                  title: "Populares",
                  loadNextPage: () =>
                      ref.read(popularMovieProvider.notifier).loadNextPage()),
              MovieHorizontalListview(
                  movies: topRatedMoviesProvider,
                  title: "Mejor Calificadas",
                  subTitle: "Desde siempre",
                  loadNextPage: () =>
                      ref.read(topRatedMovieProvider.notifier).loadNextPage()),
              const SizedBox(
                height: 10,
              )
            ],
          );
        }, childCount: 1))
      ],
    );
  }
}
