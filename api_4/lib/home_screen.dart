import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var data;

  Future<void> getUser() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      data = jsonDecode(response.body.toString());
    } else {

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('API Application'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
                future: getUser(),
                builder: (context,snapshot) {
                  if(snapshot.connectionState == ConnectionState.waiting)
                    {
                      return const Center(child: CircularProgressIndicator(),);
                    }
              else{
                    return ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: data.length,
                        itemBuilder: (context,index){
                          return Card(
                            child: Column(
                              children: [
                                ReuseAbleRow(title: "Name", value: data[index]["name"].toString()),
                                ReuseAbleRow(title: "Username", value: data[index]["username"].toString()),
                                ReuseAbleRow(title: "Email", value: data[index]["email"].toString()),
                              ],
                            ),
                          );
                        }
                    );
                  }
            }),
          ),
        ],
      ),
    );
  }
}


class ReuseAbleRow extends StatelessWidget {
  String title,value;
   ReuseAbleRow({super.key,required this.title,required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title),
          Text(value),
        ],
      ),
    );
  }
}
