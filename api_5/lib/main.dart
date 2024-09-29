import 'dart:convert';

import 'package:api_5/home_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  
  void login(String email, String password) async {
    try{
      Response response = await post(
          Uri.parse('https://reqres.in/api/register'),
        body: {
          'email':email,
          'password':password
        }
      );
      if(response.statusCode == 200)
        {
          var data = jsonDecode(response.body.toString());
          print(data.toString());
          print('Successful Login');
        }
      else
        {
          print('Login Fail');
        }
    }
    catch(e){
      print(e.toString());
    }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('SignUp Application'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                controller: emailController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  fillColor: Colors.grey.withOpacity(0.1),
                  filled: true,
                  hintText: "Enter email",
                  prefixIcon: Icon(Icons.email_outlined,color: CupertinoColors.inactiveGray.withOpacity(0.8),),
                  hintStyle: TextStyle(color: CupertinoColors.inactiveGray,fontStyle: FontStyle.normal),
                  focusedBorder: OutlineInputBorder(
                    borderSide:BorderSide(color: Colors.black.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(10)
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                  )
                ),
              ),
              SizedBox(height: 10,),
              TextFormField(
                controller: passwordController,
                cursorColor: Colors.black,
                decoration: InputDecoration(
                  hintText: 'Enter password',
                  hintStyle: TextStyle(color: CupertinoColors.inactiveGray,fontStyle: FontStyle.normal),
                  fillColor: CupertinoColors.inactiveGray.withOpacity(0.1),
                  filled: true,
                  prefixIcon: Icon(Icons.lock,color: CupertinoColors.inactiveGray.withOpacity(0.8),),
                  suffixIcon: Icon(Icons.remove_red_eye_outlined,color: Colors.grey.withOpacity(0.8),),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.3)),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide(color: Colors.black.withOpacity(0.3))
                  )
                ),
              ),
              SizedBox(height:30),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreen()));
                 login(emailController.text.toString(),passwordController.text.toString());
                },
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(

                    color: Colors.green.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Center(child: Text('Sign UP')),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

