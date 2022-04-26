import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ClubsProvider extends ChangeNotifier{

  Stream<QuerySnapshot> clubsStream = FirebaseFirestore.instance
      .collection('/entities/entities_list/names').orderBy('name')
      .snapshots();

}