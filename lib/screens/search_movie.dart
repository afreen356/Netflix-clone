import 'package:clone/model/movie.dart';
import 'package:clone/widgets/constants.dart';
import 'package:flutter/material.dart';

class SearchMovie extends StatelessWidget {
  const SearchMovie({super.key, required this.movie});

  final Movie movie;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: size.width * 0.3,
            height: size.height * 0.2,
            child: Image.network(
              '${Constants.imagePath}${movie.posterPath}',
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    movie.title,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 5), // Add spacing between title and overview
                  Text(
                    movie.overView,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    ),
                    maxLines: 4,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
