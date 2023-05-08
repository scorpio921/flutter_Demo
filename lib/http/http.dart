import 'dart:async';
import 'dart:convert' as Convert;
import 'dart:io';
import 'package:http/http.dart' as http;

// http请求有三种方式，第一种 io.dart里的HttpClient实现，第二种dart 原生库里的http库


typedef RequestCallBack = void Function(Map data);  //将函数分给typedef变量

class HttpRequest{
   static requestGet(
      String authority, String unencodePath, RequestCallBack callBack,
      [Map<String, String> queryParameters]) async{
        try{
          var httpClient = new HttpClient();
          var uri = new Uri.http(authority,unencodePath,queryParameters);
          var request = await httpClient.getUrl(uri);
          var response = await request.close();
          var responseBody = await response.transform(Convert.utf8.decoder).join();
          Map data = Convert.jsonDecode(responseBody);
          callBack(data);
        } on Exception catch(e){
          print(e.toString());
        }
      }

      final baseUrl; //用final修饰的变量，必须在定义时将其初始化，其值在初始化后不可改变
      HttpRequest(this.baseUrl);
      Future<dynamic> get(String uri,{Map<String,String> headers}) async{ //Dart 的异步对象，类似于 Javascript 中的 Promise。
        try{
          http.Response response = await http.get(baseUrl+uri,headers: headers);
          final statusCode = response.statusCode;
          final body = response.body;
          print('[uri=$uri][statusCode=$statusCode][response=$body]');
          var result = Convert.jsonDecode(body);
          return result;
        } on Exception catch (e){
          print('[uri=$uri]exception e=${e.toString()}');
          return '';
        }
      }


      Future<dynamic> getResponseBody(String uri,{Map<String,String> headers}) async{
        try{
          http.Response response = await http.get(baseUrl+uri,headers: headers);
          final statusCode = response.statusCode;
          final body = response.body;
          print('[uri=$uri][statusCode=$statusCode][response=$body]');
          return body;
        }on Exception catch(e){
          print('[uri=$uri]exception e=${e.toString()}');
          return null;
        }
      }


      Future<dynamic> post(String uri,dynamic body,{Map<String,String> headers}) async{
        try{
          http.Response response = await http.post(baseUrl+uri, body: body, headers: headers);
          final statusCode = response.statusCode;
          final responseBody = response.body;
          var result = Convert.jsonDecode(responseBody);
          print('[uri=$uri][statusCode=$statusCode][response=$responseBody]');
          return result;
        }on Exception catch(e){
          print('[uri=$uri]exception e=${e.toString()}');
          return '';
        }
      }


}