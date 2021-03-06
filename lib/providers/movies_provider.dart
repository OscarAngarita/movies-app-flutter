import 'dart:async';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;

import 'package:movies_app/helpers/debouncer.dart';
import 'package:movies_app/models/models.dart';

class MoviesProvider extends ChangeNotifier{

  String _baseUrl = 'api.themoviedb.org';
  String _apiKey = '88f1a27550ba84026d2e13f2dadc37cb';
  String _language = 'es-ES';

  List<Movie> onDisplayMovies = [];
  List<Movie> popularMovies = [];

  Map<int, List<Cast>> movieCast = {};

  int _popularPage = 0;


  final debouncer = Debouncer( //Define new debouncer
    duration: Duration(milliseconds: 500),
  );

  final StreamController<List<Movie>> _suggestionStreamController = new StreamController.broadcast();
  Stream<List<Movie>> get suggestionStream => this._suggestionStreamController.stream;



  MoviesProvider() { //Class constructor
    print('MoviesProvider inicializado');

    this.getOnDisplayMovies();
    this.getPopularMovies();
  }


  Future<String> _getJsonData(String endpoint, [int page = 1]) async {
    final url = Uri.https(_baseUrl, endpoint, {
      'api_key' : _apiKey,
      'language' : _language,
      'page' : '$page'
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await http.get(url);
    return response.body;
  }

  getOnDisplayMovies() async {
    final jsonData = await this._getJsonData('3/movie/now_playing');
    final nowPlayingResponse = NowPlayingResponse.fromJson(jsonData);
    
    onDisplayMovies = nowPlayingResponse.results;

    notifyListeners();
  }

  getPopularMovies() async {
    _popularPage++;
    
    final jsonData = await this._getJsonData('3/movie/popular', _popularPage);
    final popularResponse = PopularResponse.fromJson(jsonData);
    
    popularMovies = [...popularMovies, ...popularResponse.results]; 
    //Using spread operator to separate each movie from the list. Also it is adding the new movies to the already known popular movies.
    
    notifyListeners();
  }

  Future<List<Cast>> getMovieCast(int movieId) async { //Async converts into a Future every return that it's resolved

    if(movieCast.containsKey(movieId)) return movieCast[movieId]!; //Check if the cast it's already into the local storage to avoid making another api request

    final jsonData = await this._getJsonData('3/movie/$movieId/credits');
    final creditsResponse = CreditsResponse.fromJson(jsonData);

    movieCast[movieId] = creditsResponse.cast;

    return creditsResponse.cast;
  }

  Future<List<Movie>> searchMovies(String query) async {
    final url = Uri.https(_baseUrl, '3/search/movie', {
      'api_key' : _apiKey,
      'language' : _language,
      'query' : query,
    });

    final response = await http.get(url);
    final searchMoviesResponse = SearchMoviesResponse.fromJson(response.body);

    return searchMoviesResponse.results;
  }

  void getSuggestionsByQuery(String searchTerm){

    debouncer.value = '';
    debouncer.onValue = (value) async {
      // print('Hay valor a buscar: $value');
      final results = await this.searchMovies(value);
      this._suggestionStreamController.add(results);
    };

    final timer = Timer.periodic(Duration(milliseconds: 300), (_) { 
      debouncer.value = searchTerm;
    });

    Future.delayed(Duration(milliseconds: 301)).then((_) => timer.cancel());
  }


}