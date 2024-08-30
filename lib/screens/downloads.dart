import 'package:flutter/material.dart';

class DownloadScreen extends StatelessWidget {
  const DownloadScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          SizedBox(height: 40,),
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text('My Downloads',style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),),
                SizedBox(width: 10,),
                Icon(Icons.download,size: 28,color: Colors.grey,)
              ],
            ),
          ),
          SizedBox(height: 200,),
          Center(
            child: Container(
              height: 30,
              width: 120,
              color: Colors.grey,
              child: Center(child: Text('No downloads',style: TextStyle(color: Colors.black),))),
          )
        ],
      ) ,
    );
  }
}