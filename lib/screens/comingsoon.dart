

import 'package:clone/widgets/constants.dart';
import 'package:flutter/material.dart';
import 'package:clone/api/api.dart';
import 'package:clone/model/movie.dart';
import 'package:intl/intl.dart';


class ComingSoon extends StatefulWidget {
  const ComingSoon({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UpComingScreenState createState() => _UpComingScreenState();
}

class _UpComingScreenState extends State<ComingSoon> {
  late ValueNotifier<List<Movie>> upcomingNotifier;

  @override
  void initState() {
    super.initState();
    upcomingNotifier = ValueNotifier<List<Movie>>([]);
    fetchUpcomingMovies();
  }

  Future<void> fetchUpcomingMovies() async {
    try {
      List<Movie> upcomingMovies = await Api().getUpcoming();
      upcomingNotifier.value = upcomingMovies;
    } catch (e) {
      throw Exception('No movies');
    }
  }

  @override
   Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 30, left: 10),
              child: Text(
                'Coming Soon',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            ValueListenableBuilder<List<Movie>>(
              valueListenable: upcomingNotifier,
              builder: (context, upcomingMovies, child) {
                if (upcomingMovies.isEmpty) {
                  return Center(
                    child: const Text(
                      'No upcoming movies available',
                      style: TextStyle(color: Colors.white, fontSize: 25),
                    ),
                  );
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: upcomingMovies.map((movie) {
                      final releaseDate = DateTime.parse(movie.releaseDate);
                      final month = DateFormat('MMM').format(releaseDate);
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              month,
                              style: TextStyle(
                                color: Colors.white24,
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network(
                                    '${Constants.imagePath}${movie.posterPath}',
                                    height: 150,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    filterQuality: FilterQuality.high,
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    movie.overView,
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
           
        
    
      // body: CustomScrollView(
      //   slivers: [
      //     SliverAppBar.large(
      //       leading: IconButton(
      //         onPressed: () {
      //           Navigator.of(context).pop();
      //         },
      //         icon: const Icon(
      //           Icons.arrow_back_rounded,
      //           color: Colors.white,
      //         ),
      //       ),
      //       backgroundColor: Colors.black26,
      //       expandedHeight: 350,
      //       // pinned: true,
      //       // floating: true,
      //       flexibleSpace: FlexibleSpaceBar(
      //         title: Text('Upcoming Movies'),
      //         background: ClipRRect(
      //           borderRadius: const BorderRadius.only(
      //             bottomLeft: Radius.circular(25),
      //             bottomRight: Radius.circular(25),
      //           ),
      //           child: ValueListenableBuilder<List<Movie>>(
      //             valueListenable: upcomingNotifier,
      //             builder: (context, upcomingMovies, child) {
      //               if (upcomingMovies.isEmpty) {
      //                 return const Center(child: Text('No upcoming movies available.'));
      //               }

      //               // Display the first upcoming movie's poster as a background
      //               return Row(
      //                 children: [
      //                   Text(movie.releaseDate),
      //                   Image.network(
      //                     '${Constants.imagePath}${upcomingMovies[0].posterPath}',
      //                     fit: BoxFit.cover,
      //                     filterQuality: FilterQuality.high,
      //                   ),
      //                 ],
      //               );
      //             },
      //           ),
      //         ),
      //       ),
      //     ),
      //     SliverToBoxAdapter(
      //       child: Padding(
      //         padding: const EdgeInsets.all(12),
      //         child: ValueListenableBuilder<List<Movie>>(
      //           valueListenable: upcomingNotifier,
      //           builder: (context, upcomingMovies, child) {
      //             if (upcomingMovies.isEmpty) {
      //               return const Center(child: Text('No upcoming movies available.'));
      //             }

      //             return Column(
      //               children: upcomingMovies.map((movie) {
      //                 return ListTile(
      //                   leading: Image.network(
      //                     '${Constants.imagePath}${movie.posterPath}',
      //                     fit: BoxFit.cover,
      //                   ),
      //                   title: Text(movie.title),
      //                   subtitle: Text(movie.releaseDate),
      //                   onTap: () {
      //                     // Navigate to movie details screen
      //                   },
      //                 );
      //               }).toList(),
      //             );
      //           },
      //         ),
      //       ),
      //     ),
      //   ],
      // ),
    
  

  @override
  void dispose() {
    upcomingNotifier.dispose();
    super.dispose();
  }
}



