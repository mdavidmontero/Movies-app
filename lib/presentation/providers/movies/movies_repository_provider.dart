import 'package:cinemapedia/infrastructure/datasources/moviedb_datasource.dart';
import 'package:cinemapedia/infrastructure/repositories/movie_repository.imp.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Es inmutable 
final movieRepositoryProvider = Provider((ref) {
  return MovieRepositoryImp(MoviedbDatasource());
});
