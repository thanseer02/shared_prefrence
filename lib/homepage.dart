import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
class home extends StatefulWidget {
  const home({super.key});

  @override
  State<home> createState() => _homeState();
}

class _homeState extends State<home> {
  Future <dynamic> getdata()async{
    var response=await get(Uri.parse("https://dummyjson.com/products"));
    if (response.statusCode==200) {
      print('success');
      return jsonDecode(response.body);
    }
    else{
      print('Error');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Container(
            height: double.infinity,
            child: FutureBuilder(
              future: getdata(),
              builder: (
                  BuildContext context, AsyncSnapshot<dynamic> snapshot)
              {
                      return ListView.builder(
                      itemCount: snapshot.data['products'].length,
                          itemBuilder: (context,index) {
                        if (snapshot.hasData) {

              return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
              children: [
                SizedBox(height: 20,),

                Container(
                    child: Image(
                      image: NetworkImage(
                        '${snapshot.data['products'][index]['thumbnail']}',),fit: BoxFit.cover,)),

                Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
              Text('${snapshot.data['products'][index]['id']}',style: TextStyle(fontSize: 12,color: Colors.black45,fontWeight: FontWeight.bold),),
              ],
              ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text( ' ${snapshot.data['products'][index]['title']}',style: TextStyle(fontSize: 20,color: Colors.black45,fontWeight: FontWeight.bold),),
                  ],
                ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                Text('${snapshot.data['products'][index]['description']}',style: TextStyle(fontSize: 12,color: Colors.black45,fontWeight: FontWeight.bold),),
                ],
                ),
              ),
              SizedBox(height: 10,),
              Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
              Text('\$ ${snapshot.data['products'][index]['price']}',style: TextStyle(fontSize: 30,color: Colors.black45,fontWeight: FontWeight.bold),),
                 Row(
                   children: [
                     Text('${snapshot.data['products'][index]['rating']} ',style: TextStyle(fontSize: 22,color: Colors.amber,fontWeight: FontWeight.bold),),
                     Icon(Icons.star,color: Colors.amber,)

                   ],
                 ),

              ],
              ),
              
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Stock :  ${snapshot.data['products'][index]['stock']}',style: TextStyle(fontSize: 20,color: Colors.black45,fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('Brand : ${snapshot.data['products'][index]['brand']}',style: TextStyle(fontSize: 20,color: Colors.black45,fontWeight: FontWeight.bold),),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text('category : ${snapshot.data['products'][index]['category']}',style: TextStyle(fontSize: 15,color: Colors.black45,fontWeight: FontWeight.bold),),
                  ],
                ),
                Container(
                height: 200,
                width: double.infinity,
              // color: Colors.red,
              child: ListView.builder(
              itemCount: snapshot.data['products'][index]['images'].length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context,i) {
                return Container(
                    height: 120,
                    width: 200,
                    child: Image(
                      image: NetworkImage('${snapshot.data['products'][index]['images'][i]}',),
                      fit: BoxFit.contain,));
              })
              )
              ],
              ),
              ),
              );
              }}
                      );
              },
                      )
                      )

          ),
    );

  }
}
