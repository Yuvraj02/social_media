import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class PostCard extends StatelessWidget {
  String url;
  String caption;
  String name;

  PostCard(this.url, this.caption,this.name);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CircleAvatar(backgroundColor: Colors.white,),
              ),
              Text(name),
            ],
          ),
          Container(
            height: 350,
            width: 1080,
            child: CachedNetworkImage(imageUrl:url,fit: BoxFit.fill,),
            // decoration: BoxDecoration(
            //     image: DecorationImage(
            //         image: NetworkImage(url), fit: BoxFit.fill)),
          ),
          Row(
            children: [
              IconButton(
                  onPressed: () {}, icon: Icon(Icons.thumb_up_alt_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.comment_outlined)),
              IconButton(onPressed: () {}, icon: Icon(Icons.share_outlined)),
              Spacer(),
              IconButton(onPressed: () {}, icon: Icon(Icons.bookmark_border)),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Text("$name ",style: TextStyle(fontWeight: FontWeight.bold),),
                Text(caption)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
