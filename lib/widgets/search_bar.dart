import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  const SearchBar({Key? key}) : super(key: key);

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey,
      ),
      width: MediaQuery.of(context).size.width,
      height: 40,
      child: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Row(
          children: [
            const Icon(Icons.search),
            const SizedBox(width: 4,),
            Expanded(
              child: TextFormField(
                controller: searchController,
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search User"),
              ),
            )
          ],
        ),
      ),
    );
  }
}