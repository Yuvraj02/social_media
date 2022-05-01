import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ClubsProvider extends ChangeNotifier {

  final Stream<QuerySnapshot> clubsStream =
      FirebaseFirestore.instance.collection('users').where('isAnEntity',isEqualTo:true).snapshots();
 // TODO: //This is giving error, FIX IT!
}
