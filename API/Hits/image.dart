import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:yotube/view/API/Models/image/Photomodel.dart';
class image_api extends StatefulWidget {
  const image_api({Key? key}) : super(key: key);

  @override
  State<image_api> createState() => _image_apiState();
}

class _image_apiState extends State<image_api> {
  List<Photomodel> photolist=[];
  Future<List<Photomodel>> photo()async{
    final response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data=jsonDecode(response.body.toString());
    if (response.statusCode==200) {
      for(Map i in data){
        photolist.add(Photomodel.fromJson(i));
      }
      return photolist;
    } else {
      return photolist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example 2"),
      ),
      body: Column(
        children: [
          Expanded(child: FutureBuilder(
            future: photo(),
            builder: (context,snapshot){
              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );

              }
              return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (itemBuilder,index){
                    final data=snapshot.data![index];
return Card(
  elevation: 4,
  shadowColor: Colors.black,
  child:   ListTile(
    title: Text(data.title.toString()),
    subtitle: Text(data.id.toString()),
    leading: CircleAvatar(
      backgroundColor: Colors.black45,
      backgroundImage: NetworkImage(

        data.url.toString()

      ),

    ),

  ),
);
              });
            },
          ))
        ],
      ),
    );
  }
}
