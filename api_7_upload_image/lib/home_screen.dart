import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  File? image;
  final _picker = ImagePicker();
  bool showSpinner = false;

  Future getImage() async{
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery,imageQuality: 80);

    if(pickedFile != null){
      image = File(pickedFile.path);
      setState(() {

      });
    }
    else{
      print('Not image Selected');
    }
  }

  Future<void> uploadImage() async{

    var stream = new http.ByteStream(image!.openRead());
    stream.cast();

    var length = await image!.length();
    
    var uri = Uri.parse("https://fakestoreapi.com/products");

    var request = new http.MultipartRequest("POST",uri);

    request.fields["title"] = "Static title";

    var multiport = http.MultipartFile("image",stream,length);

    request.files.add(multiport);

    var response = await request.send();

    if(response.statusCode == 200){
      print("Image successfull upload");
    }
    else{
      print("Image Failed");
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Upload Image",style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: (){
              getImage();
            },
            child: Container(
              child: image == null ? Center(child: Text('Pick Image'),)
                  :
              Container(
                      child: Center(
                        child: Image.file(
                          File(image!.path).absolute,
                          height: 200,
                          width: 200,
                        ),
                      ),
                    ),
            ),
          ),
          SizedBox(height: 100,),
          GestureDetector(
            onTap: (){
              uploadImage();
            },
            child: Container(
              height: 80,
              width: 150,
              decoration: BoxDecoration(
                color: Colors.green,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Center(child: Text("Upload Image"),),
            ),
          )
        ],
      ),
    );
  }
}
