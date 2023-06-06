import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import '../Models/post_model/Postmodel.dart';
class post_api extends StatefulWidget {
  const post_api({Key? key}) : super(key: key);
  @override
  State<post_api> createState() => _post_apiState();
}
class _post_apiState extends State<post_api> {
  List<Postmodel> postlist=[];
  Future<List<Postmodel>> post()async{
    final response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/photos"));
    var data=jsonDecode(response.body.toString());
    if (response.statusCode==200) {
      for(Map i in data){
        postlist.add(Postmodel.fromJson(i));
      }
      return postlist;
    } else {
      return postlist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Example 3"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: post(),
                builder: (context,AsyncSnapshot<List<Postmodel>> snapshot){
                  if (!snapshot.hasData) {
                    return Center(
                      child: CircularProgressIndicator(

                      ),
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
                            title: Text(
                                data.title.toString(),style: TextStyle(
                              fontSize: 20,
                            ),
                            ),
                            subtitle: Text(
                                data.id.toString(),
                              style: TextStyle(
                                fontSize: 14,
                              ),
                            ),
                          ),
                        );
                      });
                }),
          )
        ],
      ),
    );
  }
}
