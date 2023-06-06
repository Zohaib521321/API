import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../Models/UserModel.dart';
class user extends StatefulWidget {
  const user({Key? key}) : super(key: key);

  @override
  State<user> createState() => _userState();
}

class _userState extends State<user> {
  List<UserModel> userlist=[];
  Future<List<UserModel>> user()async{
    final response=await http.get(Uri.parse("https://jsonplaceholder.typicode.com/users"));
    var data=jsonDecode(response.body.toString());
    if (response.statusCode==200) {
      for(Map i in data){
        userlist.add(UserModel.fromJson(i));
      }
      return userlist;
    } else {
      return userlist;
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("User List"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: user(),
                builder: (context,AsyncSnapshot<List<UserModel>> snapshot){
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
    data.username.toString()
  ),
    subtitle: Text(
      data.id.toString()
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
