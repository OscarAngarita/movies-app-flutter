import 'package:flutter/material.dart';


class MovieSlider extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 260,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //Bottom Section. Title
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Text('Populares', style:TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          ),

          SizedBox(height: 5),

          //Bottom Section. Items
          Expanded(
            child: ListView.builder(
              //ListBuilder defines its width according to the parent widget
              //If the parent it's flexible then an error ocurrs. Wrap parent with Expanded
              scrollDirection: Axis.horizontal,
              itemCount: 20,
              itemBuilder: ( _ , int index) => _MoviePoster()
            ),
          )
        ],
      ),
    );
  }
}


class _MoviePoster extends StatelessWidget {

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
                image: NetworkImage('https://via.placeholder.com/300x400'),
              ),
            ),
          ),
          
          SizedBox(height: 5),

          Text(
            'Kimetsu no Yaiba: Demon Slayer the Infinite train',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}