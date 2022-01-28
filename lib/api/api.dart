import 'dart:convert';
import 'package:http/http.dart' as http;

class CallApi {
  //home page api url
  var baseurl = 'https://api.comick.fun/chapter?page=1&order=hot';
  var baseurlforNew = 'https://api.comick.fun/chapter?page=1&order=new';
  var baseurlforView =
      'https://api.comick.fun/search?page=1&limit=50&sort=view';
  var baseurlforRating =
      'https://api.comick.fun/search?page=1&limit=50&sort=rating';

  //chapter api
  var ChapterDetaislByName = 'https://api.comick.fun/comic/';
  var ChapterDetaislByID = 'https://api.comick.fun/comic/';

  var token;

//home page api
  getMangas(apiUrl) async {
    var fullUrl = Uri.parse(baseurl + apiUrl);
    return await http.get(
      fullUrl,
    );
  }

  getNewMangas(apiUrl) async {
    var fullUrl = Uri.parse(baseurlforNew + apiUrl);
    return await http.get(
      fullUrl,
    );
  }

  getViewMangas(apiUrl) async {
    var fullUrl = Uri.parse(baseurlforView + apiUrl);
    return await http.get(
      fullUrl,
    );
  }

  getRatingMangas(apiUrl) async {
    var fullUrl = Uri.parse(baseurlforRating + apiUrl);
    return await http.get(
      fullUrl,
    );
  }

//chapter
  getChapterUsingName(apiUrl) async {
    var fullUrl = Uri.parse(ChapterDetaislByName + apiUrl);
    return await http.get(
      fullUrl,
    );
  }

  getChapterUsingID(apiUrl) async {
    var fullUrl = Uri.parse(ChapterDetaislByID + apiUrl);
    return await http.get(
      fullUrl,
    );
  }

  _setHeaders() => {
        'Content-type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token'
      };

  // _getToken() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   var token = localStorage.getString('token');
  //   return '?token=$token';
}
