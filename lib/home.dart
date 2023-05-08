
import 'package:flutter/material.dart';
class FavoritePage extends StatelessWidget{
  var favorites=['red','yellow'];
  @override
  Widget build(BuildContext context){
    // var appState = context.watch<MyAppState>();
    // if(appState.favorites.isEmpty){
    //   return Center(
    //     child: Text('您还没有喜欢的单词哦~'),
    //   );
    // }
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.all(10),
          child: Text('你有${favorites.length}个喜欢的,啊哈哈哈'),
        ),
        for (var pair in favorites)
        ListTile(
          leading: Icon(Icons.favorite),
          title: Text(pair),
        )
      ],
    );
  }
}