import 'package:clone/screens/details.dart';
import 'package:clone/widgets/constants.dart';
import 'package:flutter/material.dart';

class TrendingMovies extends StatelessWidget {
  const TrendingMovies({
    super.key,required this.snapshot,
  });

  final AsyncSnapshot snapshot;

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: 200,
    width: double.infinity,
    child: ListView.builder(
      scrollDirection: Axis.horizontal,
      physics: BouncingScrollPhysics(),
      itemCount: snapshot.data.length,
      itemBuilder: (context,index){
       return Padding(padding: EdgeInsets.all(8),
       child: GestureDetector(
        onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailScreen(movie: snapshot.data[index])));
        },
         child: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: SizedBox(
            
            height: 200,
            width: 150,
            child: Image.network(
              filterQuality:FilterQuality.high ,
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