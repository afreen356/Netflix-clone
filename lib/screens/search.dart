import 'dart:async';
import 'package:clone/api/api.dart';
import 'package:clone/model/movie.dart';
import 'package:clone/screens/search_movie.dart';
import 'package:clone/widgets/bottomnav.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String query ='';
  Future<List<Movie>>? searchResults;
  Timer? _debounce;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   searchResults =Api().getAllMovies();
  }

  void searchMovies(String query){
    setState(() {
      searchResults=Api().searchMovies(query);
    });
  }

  void debounce(String value){
    if(_debounce?.isActive??false)_debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
     setState(() {
       query =value;
       searchMovies(query);
     });
     });
  }
  
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>BottomNav()));
        }, icon: const Icon(Icons.arrow_back,color: Colors.grey,)),
      ),
      backgroundColor: Colors.black,
      body: Column(children: [
        Container(
          height:40 ,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 45, 45, 45)
          ),
          child:  Row(
            children: [
              const SizedBox(width: 15,),
              const Padding(
                padding: EdgeInsets.only(bottom: 5),
                child: Icon(Icons.search,size: 25,color: Colors.grey,),
              ),
              const SizedBox(width: 10,),
               Expanded(
                  child: TextField(
                    style: const TextStyle(color: Colors.white),
                    decoration: const InputDecoration(
                      hintText: "Search for a title, person, or genre",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                     debounce(value);
                    },
                  ),
                ),
              ],
            ),
          ),

          Expanded(child: FutureBuilder<List<Movie>>(
            future: searchResults, 
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return const Center(child: CircularProgressIndicator(),);
            }else if(snapshot.hasError){
              return Center(child: Text('Error${snapshot.error}',style: const TextStyle(color: Colors.white),),);
            }else if(!snapshot.hasData){
              return const Center(child: Text('No movies found'),);
            }else{
               return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final movie = snapshot.data![index];
                            return SearchMovie(movie: movie);
            }
               );
            }
          }))
            ],
          ),
          
        );
      
  }
}