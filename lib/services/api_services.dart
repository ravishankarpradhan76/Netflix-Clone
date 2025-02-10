import 'dart:convert';
import 'dart:developer';
import 'package:netfllix_clone/common/utils.dart';
import 'package:http/http.dart' as http;
import 'package:netfllix_clone/models/movie_detail_model.dart';
import 'package:netfllix_clone/models/movie_recommendation_mode.dart';
import 'package:netfllix_clone/models/search_model.dart';
import 'package:netfllix_clone/models/tv_series_model.dart';
import 'package:netfllix_clone/models/upcoming_movie_model.dart';

const baseUrl = "https://api.themoviedb.org/3/";
var key = "?api_key=$apiKey";
late String endPoint;

class ApiServices {
  Future<UpcomingMovieModel> getUpcomingMovies() async {
    endPoint = "movie/upcoming";
    final url = "$baseUrl$endPoint$key";

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log("Success");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Faild to load upcoming movie");
  }

  Future<UpcomingMovieModel> getNowPlayingMovies() async {
    endPoint = "movie/now_playing";
    final url = "$baseUrl$endPoint$key";
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print("Success");
      return UpcomingMovieModel.fromJson(jsonDecode(response.body));
    }
    throw Exception("Faild to load now playing  movie");
  }

  Future<TvSeriesModel> getTopRatedSeries() async {
    endPoint = 'tv/1396/recommendations';
    final url = '$baseUrl$endPoint$key';

    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      print('success');
      return TvSeriesModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load top rated series');
  }

  Future<SearchModel> getSearchedMovie(String searchText) async {
    endPoint = 'search/movie?query=$searchText';
    final url = '$baseUrl$endPoint';
    print(url);
    final response = await http.get(Uri.parse(url), headers: {
      'Authorization':
      'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI3NTAyYjhjMDMxYzc5NzkwZmU1YzBiNGY5NGZkNzcwZCIsInN1YiI6IjYzMmMxYjAyYmE0ODAyMDA4MTcyNjM5NSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.N1SoB26LWgsA33c-5X0DT5haVOD4CfWfRhwpDu9eGkc'
    });
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log('success');
      return SearchModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load  search movie ');
  }

  Future<MovieRecommendationsModel> getPopularMovies() async {
    endPoint = 'movie/popular';
    final url = '$baseUrl$endPoint$key';
    print(url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success');
      return MovieRecommendationsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load  popular movie ');
  }

  Future<MovieDetailModel> getMoviesDetail(int movieId) async {
    endPoint = 'movie/$movieId';
    final url = '$baseUrl$endPoint$key';
    print(url);
    final response = await http.get(Uri.parse(url));
    if (response.statusCode == 200) {
      log('success');
      log(response.body);
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load movie Detail ');
  }

  Future<MovieRecommendationsModel> getMovieRecommendations() async {
    endPoint = 'movie/popular';
    final url = '$baseUrl$endPoint$key';
    print(url);
    final response = await http.get(Uri.parse(url));
    log('success -- recommended movie');
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      log('success -- recommended movie');
      log(response.body);
      return MovieRecommendationsModel.fromJson(jsonDecode(response.body));
    }
    throw Exception('failed to load more like this ');
  }
  // Future<MovieRecommendationsModel> getMovieRecommendations() async {
  //   endPoint = 'movie/popular';
  //   final url = '$baseUrl$endPoint$key';
  //
  //   final response = await http.get(Uri.parse(url), headers: {});
  //   if (response.statusCode == 200) {
  //     log('success');
  //     return MovieRecommendationsModel.fromJson(jsonDecode(response.body));
  //   }
  //   throw Exception('failed to load now playing movies');
  // }

}
