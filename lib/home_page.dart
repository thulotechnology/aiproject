import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

bool loading = true;
File _image;
List _output;

final picker = ImagePicker();

// Loading Model
loadModel() async{
await Tflite.loadModel(model: 'assets/model_unquant.tflite', 
labels: 'assets/labels.txt');
}

pickImageFromCamera() async{
  var image = await picker.getImage(source: ImageSource.camera);
  if(image == null) return;
  setState(() {
    _image = File(image.path);
  });
classifyImage(_image);
}
pickImageFromGallery() async{
  var image = await picker.getImage(source: ImageSource.gallery);
  if(image == null) return null;
  setState(() {
    _image = File(image.path);
  });
classifyImage(_image);
}
classifyImage(File image) async{
var output = await Tflite.runModelOnImage(path: image.path,
numResults: 2,
threshold: 0.5,
imageMean: 127.5,
imageStd: 127.5
);

setState(() {
  _output = output;
  loading = false;
});
}
 @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'AI Project',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Cat and Dog Detector',
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 31),
            ),
            SizedBox(height: 42,),
            Center(
              child: loading ? Container(
                width: 280,
                child: Column(
                  children: [
                    Image.network("https://post.greatist.com/wp-content/uploads/sites/3/2020/02/322868_1100-1100x628.jpg"),
                  ],
                ),
              )  : Container(
                child: Column(
                  children: [
                    Container(
                      height: 250,
                      child: Image.file(_image),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    _output != null ? Text('Output $_output'): Container()
                  ],
                ),
              ),
            ),

            RaisedButton(
              child: Text('Import from Camera'),
              onPressed: pickImageFromCamera,
            ),
            RaisedButton(
                child: Text('Import from Gallery'),
              onPressed: pickImageFromGallery,
            ),
          ],
        ),
      ),
    );
  }
}
