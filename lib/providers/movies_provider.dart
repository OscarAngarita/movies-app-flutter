import 'package:flutter/material.dart';

class MoviesProvider extends ChangeNotifier{

  MoviesProvider() { //Class constructor
    print('MoviesProvider inicializado');

    this.getOnDisplayMovies();
  }

  getOnDisplayMovies() async {
    print('getOnDisplayMovies');
  }

}