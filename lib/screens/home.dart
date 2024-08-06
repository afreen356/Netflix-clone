import 'package:clone/api/api.dart';
import 'package:clone/model/movie.dart';
import 'package:clone/screens/details.dart';

import 'package:clone/widgets/constants.dart';
import 'package:clone/widgets/continuation.dart';
import 'package:clone/widgets/popular_movies.dart';
import 'package:clone/widgets/trending_movies.dart';

import 'package:flutter/material.dart';

class HomePge extends StatefulWidget {
  const HomePge({super.key});

  @override
  State<HomePge> createState() => _HomePgeState();
}

class _HomePgeState extends State<HomePge> {
  Future<List<Movie>>? trendingMovies;
  Future<List<Movie>>? popularMovies;
  Future<List<Movie>>? watchingUser;
  Future<List<Movie>>? previews;
  @override
  void initState() {
    super.initState();
    watchingUser = Api().getContinue();
    popularMovies = Api().getPopular();
    trendingMovies = Api().getTrendingMovies();
    previews =Api().getPreview();
  }

 

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(children: [
          Stack(children: [
            Container(
              height: size.height * 0.6,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/maharajaImage.png'),
                    fit: BoxFit.cover),
              ),
            ),
            Container(
              height: size.height * 0.6,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                      colors: [
                    Colors.black.withOpacity(0.9),
                    Colors.black.withOpacity(0.0),
                  ])),
            ),
            const Positioned(
              top: 40,
              left: 80,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                 
                  Text(
                    'TV Shows',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'Movies',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                  SizedBox(
                    width: 30,
                  ),
                  Text(
                    'My list',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: Colors.white),
                  ),
                ],
              ),
            ),
            const Positioned(
              top: 150,
              left: 150,
              child: Text(
                '#2 in India today',
                style: TextStyle(
                    height: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              ),
            ),
            Positioned(
                top: 380,
                left: 50,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Column(
                      children: [
                        Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 27,
                        ),
                        SizedBox(
                          width: 100,
                        ),
                        Text(
                          'My List',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    Container(
                      height: 45,
                      width: 100,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5)),
                      child: const Center(
                          child: Row(
                        children: [
                          SizedBox(
                            width: 8,
                          ),
                          Icon(
                            Icons.play_arrow,
                            size: 30,
                          ),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            'Play',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      )),
                    ),
                    const SizedBox(
                      width: 35,
                    ),
                    const Column(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 28,
                          color: Colors.white,
                        ),
                        Text(
                          'Info',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ],
                ))
          ]),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(
              right: 240,
            ),
            child: Text(
              'Previews',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
          const SizedBox(height: 10,),
         FutureBuilder<List<Movie>>(
  future: previews,
  builder: (context, snapshot) {
    if (snapshot.connectionState == ConnectionState.waiting) {
      return const Center(child: CircularProgressIndicator());
    } else if (snapshot.hasError) {
      return Center(
          child: Text(
        snapshot.error.toString(),
        style: const TextStyle(color: Colors.white),
      ));
    } else if (snapshot.hasData) {
      return SizedBox(
        height: 120, // Set a specific height
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: GestureDetector(
                onTap: (){
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>DetailScreen(movie: snapshot.data![index])));
                },
                child: CircleAvatar(
                  radius: 55,
                  backgroundImage: NetworkImage(
                    '${Constants.imagePath}${snapshot.data![index].posterPath}'
                  ),
                ),
              ),
            );
          },
        ),
      );
    } else {
      return const Center(child: Text('No previews available.'));
    }
  },
),
          const SizedBox(
            height: 15,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 45),
            child: Text(
              'Continue Watching For Users',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 26),
            ),
          ),
          const SizedBox(
            height: 25,
          ),
          SizedBox(
              child: FutureBuilder<List<Movie>>(
            future: watchingUser,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.white),
                ));
              } else if (snapshot.hasData) {
                print('Data${snapshot.data}');
                return WatchingUserSlider(
                  snapshot: snapshot,
                );
              } else {
                return const Center(
                    child: Text('No trending movies available.'));
              }
            },
          )),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 150),
            child: Text(
              'Popular On Netflix',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              child: FutureBuilder<List<Movie>>(
            future:popularMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.white),
                ));
              } else if (snapshot.hasData) {
                print('Data${snapshot.data}');
                return PopularMovies(snapshot: snapshot);
              } else {
                return const Center(
                    child: Text('No trending movies available.'));
              }
            },
          )),
          const SizedBox(
            height: 10,
          ),
          const Padding(
            padding: EdgeInsets.only(right: 200),
            child: Text(
              'Trending Now',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              child: FutureBuilder<List<Movie>>(
            future: trendingMovies,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                    child: Text(
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.white),
                ));
              } else if (snapshot.hasData) {
                print('Data${snapshot.data}');
                return TrendingMovies(snapshot: snapshot);
              } else {
                return const Center(
                    child: Text('No trending movies available.'));
              }
            },
          ))
        ]),
      ),
      
    );
  }
}

// class TrendingMovies extends StatelessWidget {
//   const TrendingMovies({
//     super.key, required AsyncSnapshot<List<Movie>> snapshot,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       width: double.infinity,
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           physics: BouncingScrollPhysics(),
//           itemCount: 10,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: EdgeInsets.all(8),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Container(
//                   color: Colors.amber,
//                   height: 200,
//                   width: 150,
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }

// class PopularMovies extends StatelessWidget {
//   const PopularMovies({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 200,
//       width: double.infinity,
//       child: ListView.builder(
//           scrollDirection: Axis.horizontal,
//           physics: BouncingScrollPhysics(),
//           itemCount: 10,
//           itemBuilder: (context, index) {
//             return Padding(
//               padding: EdgeInsets.all(8),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(8),
//                 child: Container(
//                   color: Colors.amber,
//                   height: 200,
//                   width: 150,
//                 ),
//               ),
//             );
//           }),
//     );
//   }
// }

// class ContinuationSlider extends StatelessWidget {
//   const ContinuationSlider({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       width: double.infinity,
//       child: CarouselSlider.builder(
//         itemCount: 10,
//         options: CarouselOptions(
//             height: 300,
//             autoPlay: true,
//             viewportFraction: 0.55,
//             enlargeCenterPage: true,
//             autoPlayCurve: Curves.fastOutSlowIn,
//             autoPlayAnimationDuration: const Duration(seconds: 1),
//             pageSnapping: true),
//         itemBuilder: (context, itemIndex, pageviewIndex) {
//           return Container(
//             height: 300,
//             width: 200,
//             decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(5), color: Colors.amber),
//           );
//         },
//       ),
//     );
//   }
// }
