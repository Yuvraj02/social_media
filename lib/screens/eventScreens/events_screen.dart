import 'package:cloud_firestore/cloud_firestore.dart';
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
      body: StreamBuilder(
        stream: provider.eventStream,
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return Text('Something went wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                 DocumentSnapshot data = snapshot.data!.docs[index];
                // EventModel eventModel = EventModel.fromJson(
                //     snapshot.data!.docs[index] as Map<String, dynamic>);
                print(snapshot.data!.docs.length);
                return ListTile(
                  onTap: (){},
                  title: Text(data['title']),
                  subtitle: Text(data['eventAuthorName']),
                );
              });
        },
      ),
    );
  }
}
