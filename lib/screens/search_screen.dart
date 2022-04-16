import 'package:flutter/material.dart';
import 'package:social_media/widgets/search_bar.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SafeArea(child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(children: [SearchBar()],),
    )),);
  }
}
