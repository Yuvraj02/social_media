import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media/providers/post_screen_provider.dart';

class StudentsOnlyPostScreen extends StatefulWidget {
  const StudentsOnlyPostScreen({Key? key}) : super(key: key);

  @override
  State<StudentsOnlyPostScreen> createState() => _StudentsOnlyPostScreenState();
}

class _StudentsOnlyPostScreenState extends State<StudentsOnlyPostScreen> {

  Uint8List? _file;
  TextEditingController postController = TextEditingController();


  _selectFileToUpload(BuildContext context, PostProvider provider) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Create a Post'),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("Take a Photo"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file = await provider.pickImage(ImageSource.camera);
                  setState(() {
                    _file = file;
                  });
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: Text("Choose From Gallery"),
                onPressed: () async {
                  Navigator.of(context).pop();
                  Uint8List file =
                  await provider.pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
              )
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    PostProvider provider = Provider.of<PostProvider>(context);
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  _selectFileToUpload(context, provider);
                },
                child: Row(
                  children: [
                    Text(
                      "Upload a Photo/Video",
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                        onPressed: () {
                         _selectFileToUpload(context, provider);
                        },
                        icon: Icon(
                          Icons.add_box,
                          color: Colors.blueGrey,
                        ))
                  ],
                ),
              ),
            ),
            _file != null
                ? Container(
              height: MediaQuery
                  .of(context)
                  .size
                  .height / 2,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: MemoryImage(_file!), fit: BoxFit.fill)),
            )
                : const SizedBox(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextField(
                    controller: postController,
                    decoration: InputDecoration(
                        hintText: 'Write Here...', border: InputBorder.none),
                  ),
                ),
                height: MediaQuery
                    .of(context)
                    .size
                    .height / 6,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                decoration: BoxDecoration(border: Border.all(color: Colors.white)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                      onPressed: () {
                        provider.uploadStudentPost(
                            file: _file, caption: postController.text);
                      },
                      icon: Icon(
                        Icons.arrow_right_alt_rounded,
                        size: 40,
                      ))),
            )
          ],
        ),
      ),
    );
  }
}
