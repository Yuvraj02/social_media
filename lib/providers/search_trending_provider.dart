import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:social_media/models/user_model.dart';

class SearchAndTrendingProvider extends ChangeNotifier {
  List<UserModel> queryResultSet = [];
  List<UserModel> tempSearchStore = [];

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  searchByName(String searchField) {
    return _firestore
        .collection('users')
        .where('searchKey', isEqualTo: searchField.substring(0, 1))
        .get();
  }

  searchByUsername(String searchField) {
    return _firestore
        .collection('users')
        .where('usernameSearchKey', isEqualTo: searchField.substring(0, 1))
        .get();
  }

  initiateSearch(String value) {
    if (value.isEmpty) {
      queryResultSet = [];
      tempSearchStore = [];
      notifyListeners();
    } else {
      var capitalizedValue =
          value.substring(0, 1).toUpperCase() + value.substring(1);
      queryByName(value, capitalizedValue);
      if (tempSearchStore.isEmpty) {
        queryByUserName(value);
      }
    }
  }

  queryByName(String value, String capitalizedValue) {
    if (queryResultSet.isEmpty && value.length == 1) {
      searchByName(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          print(docs.docs[i].data());
          queryResultSet.add(UserModel.fromJson(docs.docs[i].data() as Map<String, dynamic>));
          tempSearchStore = queryResultSet;
          notifyListeners();
        }
      });
    } else {
      tempSearchStore = [];
      for (var element in queryResultSet) {
        if (element.name!.startsWith(capitalizedValue)) {
          tempSearchStore.add(element);
          notifyListeners();
        }
      }
    }
  }

  queryByUserName(String value) {
    if (queryResultSet.isEmpty && value.length == 1) {
      searchByUsername(value).then((QuerySnapshot docs) {
        for (int i = 0; i < docs.docs.length; ++i) {
          queryResultSet.add(UserModel.fromJson(docs.docs[i].data() as Map<String, dynamic>));
          tempSearchStore = queryResultSet;
          notifyListeners();
        }
      });
    } else {
      tempSearchStore = [];
      for (var element in queryResultSet) {
        if (element.name!.startsWith(value)) {
          tempSearchStore.add(element);
          notifyListeners();
        }
      }
    }
  }
}
