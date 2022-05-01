import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:social_media/providers/event_provider.dart';

class CreateEvent extends StatefulWidget {
  const CreateEvent({Key? key}) : super(key: key);

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  bool isPosting = false;
  Uint8List? _file;
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    EventsProvider provider = Provider.of<EventsProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Create an Event"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _titleController,
                decoration: InputDecoration(hintText: 'Event Title'),
              ),
              TextField(
                controller: _descriptionController,
                decoration: InputDecoration(hintText: 'Event Description'),
              ),
              InkWell(
                onTap: () async {
                  Uint8List file =
                      await provider.pickImage(ImageSource.gallery);
                  setState(() {
                    _file = file;
                  });
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                  child: Row(
                    children: [
                      IconButton(onPressed: () {}, icon: Icon(Icons.image)),
                      Text("Pick An Image"),
                    ],
                  ),
                ),
              ),
              _file != null
                  ? Container(
                      height: MediaQuery.of(context).size.height / 2,
                      width: MediaQuery.of(context).size.width,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                              image: MemoryImage(_file!), fit: BoxFit.fill)),
                    )
                  : const SizedBox(),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now(),
                          lastDate: DateTime(2100));
                    },
                    child: Container(
                        child: Row(
                      children: [
                        IconButton(
                            onPressed: () {}, icon: Icon(Icons.calendar_today)),
                        Text("Pick Date "),
                      ],
                    )),
                  ),
                  SizedBox(
                    width: 8,
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        child: Row(
                      children: [
                        IconButton(onPressed: () {}, icon: Icon(Icons.alarm)),
                        Text("Select Time"),
                      ],
                    )),
                  ),
                ],
              ),
             isPosting?CircularProgressIndicator(): ElevatedButton(
                  onPressed: () async {
                    if (_file == null ||
                        _titleController == null ||
                        _descriptionController == null) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Kindly Check if all the fields are filled correctly")));
                    } else {
                      setState(() {
                        isPosting = true;
                      });
                      //TODO: User Await Here FOR Progress INDICATOR
                      await provider.createEvent(
                          file: _file,
                          description: _descriptionController.text,
                          title: _titleController.text);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                              "Congratulations! You have created an Event")));
                      setState(() {
                        isPosting = false;
                      });
                      Navigator.pop(context);
                    }
                  },
                  child: Text("Create Event!")),
            ],
          ),
        ),
      ),
    );
  }
}
