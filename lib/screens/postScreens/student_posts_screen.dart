import 'package:flutter/material.dart';

class StudentPosts extends StatelessWidget {
  const StudentPosts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: TextField(
                decoration: InputDecoration(
                    hintText: 'Enter Your Enquiry Here',
                    border: InputBorder.none),
              ),
            ),
            height: MediaQuery.of(context).size.height / 6,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(border: Border.all(color: Colors.white)),
          ),
        )
      ],
    );
  }
}
