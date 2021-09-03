import 'package:flutter/material.dart';
import 'package:movies_app/models/models.dart';


class MovieSlider extends StatefulWidget {

  final List<Movie> movies;
  final String? title;
  final Function onNextPage;

  const MovieSlider({
    required this.movies, 
    required this.onNextPage,
    this.title,
  });

  @override
  _MovieSliderState createState() => _MovieSliderState();
}

class _MovieSliderState extends State<MovieSlider> {

  final ScrollController scrollController = new ScrollController();

  @override
  void initState() { //Called before the widget it's built
    super.initState();
    //First call super then code

    scrollController.addListener(() { //Needs to be associated to a widget with scroll controller
     
      // print(scrollController.position.maxScrollExtent); //To find out max lenght
      if(scrollController.position.pixels >= scrollController.position.maxScrollExtent - 500) {
        widget.onNextPage();
      }

    });
  }


  @override
  void dispose() { //Called before the widget it's destroyed

    //Code then call super
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Bottom Section. Title
          if(this.widget.title != null)
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(this.widget.title!, style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),

          SizedBox(height: 5),

          //Bottom Section. Items
          Expanded(
            child: ListView.builder(
              //ListBuilder defines its width according to the parent widget
              //If the parent it's flexible then an error ocurrs. Wrap parent with Expanded
              scrollDirection: Axis.horizontal,
              controller: scrollController,
              itemCount: widget.movies.length,
              itemBuilder: ( _ , int index) => _MoviePoster(widget.movies[index])
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