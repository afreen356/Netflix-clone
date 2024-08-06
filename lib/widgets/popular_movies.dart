import 'package:clone/model/movie.dart';
import 'package:clone/screens/details.dart';
import 'package:clone/widgets/constants.dart';
import 'package:flutter/material.dart';

class PopularMovies extends StatelessWidget {
final AsyncSnapshot<List<Movie>> snapshot;

  const PopularMovies({Key? key, required this.snapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 200,
    width: double.infinity,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: snapshot.data!.length,
      itemBuilder: (context,index){
       return Padding(padding: EdgeInsets.all(8),
       child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailScreen(movie: snapshot.data![index])));
        },
         child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child:SizedBox(
           
            height: 200,
            width: 150,
            child: Image.network(
              filterQuality: FilterQuality.high,
              fit: BoxFit.cover,
              '${Constants.imagePath}${snapshot.data![index].posterPath}'
              ),
          ),
         ),
       ),
       );
    }),
    );
  }
}