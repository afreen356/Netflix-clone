import 'package:carousel_slider/carousel_slider.dart';
import 'package:clone/model/movie.dart';
import 'package:clone/screens/details.dart';
import 'package:clone/widgets/constants.dart';
import 'package:flutter/material.dart';

class WatchingUserSlider extends StatelessWidget {
final AsyncSnapshot <List<Movie>> snapshot;

   WatchingUserSlider({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: CarouselSlider.builder(
        itemCount: snapshot.data!.length,
        options: CarouselOptions(
            height: 300,
            autoPlay: true,
            viewportFraction: 0.55,
            enlargeCenterPage: true,
            autoPlayCurve: Curves.fastOutSlowIn,
            autoPlayAnimationDuration: const Duration(seconds: 1),
            pageSnapping: true),
        itemBuilder: (context, itemIndex, pageviewIndex) {
          
          return GestureDetector(
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailScreen(movie: snapshot.data![itemIndex])));
            },
            child: SizedBox(
              height: 300,
              width: 200,
              child: Image.network(
                filterQuality: FilterQuality.high,
                fit: BoxFit.cover,
                '${Constants.imagePath}${snapshot.data![itemIndex].posterPath}'
              ),
            ),
          );
        },
      ),
    );
  }
}