import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/providers/event_provider.dart';

class EventScreen extends StatefulWidget {
  const EventScreen({Key? key}) : super(key: key);

  @override
  State<EventScreen> createState() => _EventScreenState();
}

class _EventScreenState extends State<EventScreen> {
  @override
  Widget build(BuildContext context) {
    EventsProvider provider = Provider.of<EventsProvider>(context);
    provider.entityCheck();
    return Scaffold(
      appBar: AppBar(
        title: Text("Events"),
        actions: [
          IconButton(
              onPressed: () {
                provider.dialogBox(context);
              },
              icon: Icon(Icons.add_alert))
        ],
      ),
      body: Center(
        child: Text("No Event at the moment"),
      ),
    );
  }
}

