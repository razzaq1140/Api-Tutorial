import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({super.key});

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

   login(String email,String password) async{
    try{
      Response response = await post(
         Uri.parse("https://www.episodate.com/api/most-popular?page=1"),
        body: {
          "id": email,
          "name": password
      }
      );

      if(response.statusCode == 200){
        var data = jsonDecode(response.body);
        print(data["token"]);
        print("Successful");
      }
      else{
        print('fail');
      }
    }
    catch(e){
      print(e.toString());
    }
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Login Page"),backgroundColor: Colors.blue,centerTitle: true,),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
              TextFormField(
                controller: emailController,
                decoration: InputDecoration(
                hintText: "Email",
              ),),
            SizedBox(height: 10.0,),
            TextFormField(
              controller: passwordController,
              decoration: InputDecoration(
              hintText: "Password",
            ),),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                login(emailController.text.toString(),passwordController.text.toString());
              },
              child: Container(
                height: 50.0,
                child: Center(child: Text("Sign Up")),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
