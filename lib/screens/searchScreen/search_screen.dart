import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:social_media/providers/search_trending_provider.dart';
import 'package:social_media/screens/searchScreen/searched_user_profile_screen.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isSearching = false;

  @override
  Widget build(BuildContext context) {
    SearchAndTrendingProvider provider =
        Provider.of<SearchAndTrendingProvider>(context);
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
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
                    const SizedBox(
                      width: 4,
                    ),
                    Expanded(
                      child: FocusScope(
                        child: Focus(
                          onFocusChange: (focus) {
                            setState(() {
                              isSearching = focus;
                            });
                          },
                          child: TextField(
                            onChanged: (value) =>
                                provider.initiateSearch(value),
                            decoration: const InputDecoration(
                                border: InputBorder.none,
                                hintText: "Search Here"),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            !isSearching
                ? Column(
                    children: [
                      Text("Trending"),
                      ListView(
                        shrinkWrap: true,
                        scrollDirection: Axis.vertical,
                        children: [
                          Text("Trending Post 1"),
                          Text("Trending Post 2"),
                          Text("Trending Post 3"),
                          Text("Trending Post 4"),
                        ],
                      ),
                    ],
                  )
                : ListView.builder(
                    shrinkWrap: true,
                    itemCount: provider.tempSearchStore.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_)=> SearchedUserProfileScreen(provider.tempSearchStore[index])));
                        },
                        title:
                            Text(provider.tempSearchStore[index].userName),
                        subtitle: Text(provider.tempSearchStore[index].name!),
                      );
                    }),
          ],
        ),
      )),
    );
  }
}
