import 'package:flutter/material.dart';
import 'package:movies_app/providers/movies_provider.dart';

import 'package:provider/provider.dart';

import 'package:movies_app/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final moviesProvider = Provider.of<MoviesProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Peliculas en cines')),
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.search_outlined), 
            onPressed: () {}
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //Main cards
            CardSwiper(movies: moviesProvider.onDisplayMovies),
      
            //Movies slider
            MovieSlider(
              movies: moviesProvider.popularMovies,
              title: 'Populares'
            ),
          ],
        ),
      ),
    );
  }
}