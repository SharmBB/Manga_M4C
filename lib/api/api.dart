import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CallApi {
  //home page api url
  var url = 'https://api.comick.fun/chapter/';
  var baseurl = 'https://api.comick.fun/chapter?page=1&order=hot';
  var baseurlforNew = 'https://api.comick.fun/chapter?page=1&order=new';
  var baseurlforView =
      'https://api.comick.fun/search?page=1&limit=50&sort=view';
  var baseurlforRating =
      'https://api.comick.fun/search?page=1&limit=50&sort=rating';

  //chapter api
  var ChapterDetaislByName = 'https://api.comick.fun/comic/';
  var ChapterDetaislByID = 'https://api.comick.fun/comic/';

  var search = "https://api.comick.fun/search?page=1&limit=50&q=";

  // Auth Api
  var _urlAuth = 'http://api.mangakiku.com/api/';

  var token;
  //Genres api url
  var genres_baseurl = 'https://api.comick.fun/genre';
  //browser
  var hoturl = 'https://api.comick.fun/search?page=1&limit=50&sort=uploaded';
  var newurl = 'https://api.comick.fun/search?page=1&limit=50&sort=follow';

  //advance search
  var advacesearch = 'https://api.comick.fun/search?';

  var otpMail = 'https://nodeapi.mangakiku.com/enduser/';

  //post otp
  postOTP(data, apiUrl) async {
    // token = await _getToken();
    var fullUrl = Uri.parse(otpMail + apiUrl);
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }


    //post otp
  checkOTP(data, apiUrl) async {
    // token = await _getToken();
    var fullUrl = Uri.parse(otpMail + apiUrl);
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  //Login api
  authData(data, apiUrl) async {
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

//Genres api
  getGenres(apiUrl) async {
    var fullUrl = Uri.parse(genres_baseurl + apiUrl);
    return await http.get(
      fullUrl,
    );
  }

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

  getChapterImages(apiUrl) async {
    var fullUrl = Uri.parse(url + apiUrl);
    return await http.get(
      fullUrl,
    );
  }

  //browser page
  getBrowserhot(apiUrl) async {
    var fullUrl = Uri.parse(hoturl + apiUrl);
    return await http.get(
      fullUrl,
    );
  }

  //Search page
  getSearch(apiUrl) async {
    var fullUrl = Uri.parse(search + apiUrl);
    return await http.get(
      fullUrl,
    );
  }

  //browser page
  getBrowserNew(apiUrl) async {
    var fullUrl = Uri.parse(newurl + apiUrl);
    return await http.get(
      fullUrl,
    );
  }

  //get User by ID
  getUserById(apiUrl) async {
    token = await _getToken();
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

//library deletes
  deleteLibrary( apiUrl) async {
    token = await _getToken();
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.delete(
      fullUrl,
     
      headers: _setHeaders(),
    );
  }

  //favourite deletes
  deleteFavourite( apiUrl) async {
    token = await _getToken();
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.delete(
      fullUrl,
   
      headers: _setHeaders(),
    );
  }

//advance search
  getAdvaceSearch(apiUrl) async {
    var fullUrl = Uri.parse(advacesearch + apiUrl);
    return await http.get(
      fullUrl,
    );
  }

//post data
  postData(data, apiUrl) async {
    token = await _getToken();
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.post(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  //Get Comments
  getComments(apiUrl) async {
    token = await _getToken();
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  //Get Comments
  getApiSetting(apiUrl) async {
    token = await _getToken();
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  //LeaderBoard
  getLeaderBoard(apiUrl) async {
    token = await _getToken();
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  //User Library
  getUserLibrary(apiUrl) async {
    token = await _getToken();
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  //User Library
  getUserFavourite(apiUrl) async {
    token = await _getToken();
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
    );
  }

  updatePassword(data, apiUrl) async {
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.put(
      fullUrl,
      body: jsonEncode(data),
      headers: _setHeaders(),
    );
  }

  //Get Reply Comments
  getReplyComments(apiUrl) async {
    token = await _getToken();
    var fullUrl = Uri.parse(_urlAuth + apiUrl);
    return await http.get(
      fullUrl,
      headers: _setHeaders(),
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

  // }

  _getToken() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var token = localStorage.getString('token');
    return token;
  }
}
