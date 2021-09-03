import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';


class MovieSlider extends StatelessWidget {

  final List<Movie> movies;
  final String? title;

  const MovieSlider({
    required this.movies, 
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Bottom Section. Title
          if(this.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(this.title!, style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),

          SizedBox(height: 5),

          //Bottom Section. Items
          Expanded(
            child: ListView.builder(
              //ListBuilder defines its width according to the parent widget
              //If the parent it's flexible then an error ocurrs. Wrap parent with Expanded
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: ( _ , int index) => _MoviePoster(movies[index])
            ),
          )
        ],
      ),
    );
  }
}


class _MoviePoster extends StatelessWidget {

  final Movie movie;

  const _MoviePoster(this.movie);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130,
      height: 190,
      margin: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          
          GestureDetector(
            onTap: () => Navigator.pushNamed(context, 'details', arguments: 'movie-isntance'),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: FadeInImage(
                width: 130,
                height: 190,
                fit: BoxFit.cover,
                placeholder: AssetImage('assets/no-image.jpg'), 
                image: NetworkImage(movie.fullPosterImg),
              ),
            ),
          ),
          
          SizedBox(height: 5),

          Text(
            movie.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}