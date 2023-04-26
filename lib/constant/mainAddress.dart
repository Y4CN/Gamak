import 'dart:io';

class MainAddress{
  MainAddress._();
  static String apiAddress =Platform.isAndroid? 'http://10.0.2.2:8090/api/' : 'http://127.0.0.1:8090/api/';
}