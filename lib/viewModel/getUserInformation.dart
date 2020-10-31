import 'dart:convert' as convert;
import 'package:flutterprojectgitapi/class/Repository.dart';
import 'package:flutterprojectgitapi/class/UserInformation.dart';
import 'package:http/http.dart' as http;

class GetUserInformation{
  String baseUrl = 'https://api.github.com/';

  getUserPersonalInformation({userName})async{
    var url=baseUrl+"users/$userName";
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      return UserInformation.fromJson(jsonResponse);
    } else {
      return UserInformation();
    }
  }

  getUserRepos({userName})async{
    var url=baseUrl+"users/$userName/repos";
    // Await the http get response, then decode the json-formatted response.
    var response = await http.get(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      List <Repository> list=new List();
      jsonResponse.forEach((element) {
        list.add(Repository.fromJson(element));
      });
      return list;
    } else {
      return Repository();
    }

  }
}