import 'package:clone/api/api.dart';
import 'package:clone/model/movie.dart';
import 'package:clone/screens/search_movie.dart';
import 'package:flutter/material.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  String query ='';
  Future<List<Movie>>? searchResults;

  void searchMovies(String query){
    setState(() {
      searchResults=Api().searchMovies(query);
    });
  }
  
  @override
  Widget build(BuildContext context) {
    // Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(onPressed: (){
         Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back)),
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
              SizedBox(width: 15,),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Icon(Icons.search,size: 25,color: Colors.grey,),
              ),
              SizedBox(width: 10,),
               Expanded(
                  child: TextField(
                    style: TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search for a title, person, or genre",
                      hintStyle: TextStyle(color: Colors.white),
                      border: InputBorder.none,
                    ),
                    onChanged: (value) {
                      query = value;
                      searchMovies(query);
                    },
                  ),
                ),
              ],
            ),
          ),

          Expanded(child: searchResults==null?Center(
            child: Text('Search for movies',style: TextStyle(color: Colors.white),),
          ):FutureBuilder<List<Movie>>(
            future: searchResults, 
          builder: (context,snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else if(snapshot.hasError){
              return Center(child: Text('Error${snapshot.error}',style: TextStyle(color: Colors.white),),);
            }else if(!snapshot.hasData){
              return Center(child: Text('No movies found'),);
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