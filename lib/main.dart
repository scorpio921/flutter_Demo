import 'package:english_words/english_words.dart'; // 生成英文单词包
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Namer App',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 123, 191, 247)),
        ),
        home:  Scaffold(
           appBar: AppBar(
               title: Text("路由展示"),
               backgroundColor: Colors.red,
           ),
           //将封装好的路由按钮放在这里
           body:Center(
             child: button(),
           ) ,
           bottomNavigationBar: BottomNavigationBar(
            items: const<BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home)
                ,label: 'Home'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.business)
                ,label: 'Business'
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.school)
                ,label: 'School'
              ),
            ],
            selectedItemColor: Colors.amber[800],
            currentIndex:1,
            onTap:(value) => {
              print(value),
            },
          ),
       ),
      ),
    );
  }
}


//封装的RaisedButton组件实现跳转，直接放至 MaterialApp无法实现跳转，需要单独封装
class button extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
     return
       ElevatedButton(
         //onPressed就是回调函数，点击事件发生后会执行里面的内容
          onPressed:(){
               Navigator.push(context,MaterialPageRoute(builder:(context){
                   return MyHomePage();
                 }));
            },
           child: Text("跳转"),
     );
  }
}
// 
class MyAppState extends ChangeNotifier {
  var current = WordPair.random();
  // 增加一个方法
  void getNext(){
    current = WordPair.random();
    notifyListeners();
  }

  // 增加点击收藏方法
  var favorites = <WordPair>[];

  void toggleFavorite() {
    if(favorites.contains(current)){
      favorites.remove(current);
    }else{
      favorites.add(current);
    }
    notifyListeners();
  }
}
class MyHomePage extends StatefulWidget{  //StatefulWidget 控制一个小部件如何替换树中的另一个小部件
   const MyHomePage({super.key});
   @override
   State<MyHomePage> createState()=>_MyHomePageState(); //创建可更改状态
}


class _MyHomePageState extends State<MyHomePage>{
   var selectedIndex = 0;

   @override
   Widget build(BuildContext context){
    Widget page;
    switch(selectedIndex){
      case 0:
        page = GeneratorPage();
        break;
      case 1:
        page = FavoritePage();
        break;
      default:
        throw UnimplementedError('NO WEIGT');
    }
    return LayoutBuilder(builder:(context, constraints){
       return Scaffold(
         appBar: AppBar(
            title: Text("route路由"),
          ),
            body: Row(
            children: [
              SafeArea(
                child: NavigationRail(  //一个导航小组件
                  extended: constraints.maxWidth >= 600, 
                  destinations: [
                    NavigationRailDestination(
                      icon: Icon(Icons.home),
                      label: Text('Home'),
                    ),
                    NavigationRailDestination(
                      icon: Icon(Icons.favorite),
                      label: Text('Favorites'),
                    ),
                  ],
                  selectedIndex: selectedIndex,

                  onDestinationSelected: (value){
                    setState(() {
                        selectedIndex = value;
                      });
                    // print('selected:$value');
                  },
                ),

              ),
              Expanded(
                child: Container(
                  color: Theme.of(context).colorScheme.primaryContainer,
                  child: page,
                ),
              ),
            ],
            ),
          );
       
      });
   
  }
}
class GeneratorPage  extends StatelessWidget {
  // String _responseText = '';
  Future<void> _getData() async {
    print('test');
    final response = await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts/1'));
    if (response.statusCode == 200) {
      final decodedData = json.decode(response.body);
      print(decodedData['title']);
      // setState(() {
      //   _responseText = decodedData['title'];
      // });
    } else {
      // setState(() {
      //   _responseText = 'Error: ${response.statusCode}';
      // });
    }
  }
  @override
  Widget build(BuildContext context) {
    var appState = context.watch<MyAppState>();
    var pair = appState.current;
    var favorites = appState.favorites;

    IconData icon;
    if(appState.favorites.contains(pair)){
      icon = Icons.favorite;
    }else{
      icon = Icons.favorite_border;
    }
    return Center(

        child: Column(
           mainAxisAlignment: MainAxisAlignment.center, //位置上下居中
           children: [  
              IconWrap(),
              BigCard(pair: pair),
              SizedBox(height: 10),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                   ElevatedButton.icon(
                      onPressed: (){
                        // 按钮回调调用MyAppState 的方法
                        appState.toggleFavorite();
                        print(favorites);
                      },
                      icon: Icon(icon), 
                      label: Text('Like')
                    ),
                    SizedBox(width: 10),
                    ElevatedButton(onPressed: (){
                      // 按钮回调调用MyAppState 的方法
                      appState.getNext();
                      print('button 啊哈哈哈');
                    }, child: Text('Next')),
                     SizedBox(width: 10),
                      ElevatedButton(onPressed: (){
                      // 按钮回调调用MyAppState 的方法
                      // appState.getNext();
                      _getData();
                      
                    }, child: Text('http'))
                ],
              )
            
            ],
        ),
       
       
    );
  }
}
// 一些icon样式
class IconWrap extends StatelessWidget{
    @override
    Widget build(BuildContext context){
      return Container(
        // width: 100,
        // height: 200,
        // color: Color.fromARGB(255, 74, 161, 233),
        child: Row(
         mainAxisAlignment: MainAxisAlignment.center, //位置上下居中
         children: [
          Expanded(
                flex: 1,
                child: Column(children: [
                   Icon(Icons.add_call,color: Colors.amber),
                    const Text('添加电话'),
                    const Text('25 min'),
                ],)
           ),
          Expanded(
                flex: 1,
                child: Column(children: [
                   Icon(Icons.baby_changing_station),
                    const Text('洗手池'),
                    const Text('25 min'),
                ],)
           ),
           Expanded(
                flex: 1,
                child: Column(children: [
                     Icon(Icons.access_time_outlined),
                    const Text('时间'),
                    const Text('25 min'),
                ],)
           ),
         ],
        ),
      );
    }
}
// 卡片样式
class BigCard extends StatelessWidget {
  
  const BigCard({
    Key?key,
    required this.pair,
  }) : super(key: key);

  final WordPair pair;

  @override
  Widget build(BuildContext context){
    var theme = Theme.of(context);
    var style = theme.textTheme.displayMedium!.copyWith(
      color: theme.colorScheme.onPrimary,
    );
    return Card(
      color: theme.colorScheme.primary,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(pair.asPascalCase,style:style,semanticsLabel:pair.asLowerCase),
        
      ),
    );
  }
}


