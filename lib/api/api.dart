import 'dart:convert';

import 'package:clone/model/movie.dart';
import 'package:clone/widgets/constants.dart';
import 'package:http/http.dart'as http;

class Api{
   static const _trendingUrl= 'https://api.themoviedb.org/3/trending/movie/day?api_key=${Constants.apiKey}';
   static const _popular ='https://api.themoviedb.org/3/movie/popular?api_key=${Constants.apiKey}';
   static const _watchUser ='https://api.themoviedb.org/3/movie/top_rated?api_key=${Constants.apiKey}';
   static const _preview =  'https://api.themoviedb.org/3/movie/upcoming?api_key=${Constants.apiKey}';
  static const _searchUrl=  'https://api.themoviedb.org/3/search/movie?api_key=${Constants.apiKey}&query=';

  Future<List<Movie>>getTrendingMovies()async{
    final response =await http.get(Uri.parse(_trendingUrl));
    if(response.statusCode==200){
      final decodedData=json.decode(response.body)['results']as List;
      print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception('failed to load');
    }
  }

   Future<List<Movie>>getPopular()async{
    final response =await http.get(Uri.parse(_popular));
    if(response.statusCode==200){
      final decodedData=json.decode(response.body)['results']as List;
      print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception('failed to load');
    }
  }

   Future<List<Movie>>getContinue()async{
    final response =await http.get(Uri.parse(_watchUser));
    if(response.statusCode==200){
      final decodedData=json.decode(response.body)['results']as List;
      print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception('failed to load');
    }
  }

   Future<List<Movie>>getPreview()async{
    final response =await http.get(Uri.parse(_preview));
    if(response.statusCode==200){
      final decodedData=json.decode(response.body)['results']as List;
      print(decodedData);
      return decodedData.map((movie) => Movie.fromJson(movie)).toList();
    }else{
      throw Exception('failed to load');
    }
  }

Future<List<Movie>> searchMovies(String query) async {
    final response = await http.get(Uri.parse('$_searchUrl$query'));
    if (response.statusCode == 200) {
      final decodeData = json.decode(response.body)['results'] as List;
      print(decodeData); // Print the JSON response
      return decodeData.map((movie) => Movie.fromJson(movie)).toList();
    } else {
      throw Exception('Failed to load search results');
    }
  }
  
}