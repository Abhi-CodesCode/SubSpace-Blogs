import 'dart:convert';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../models/blog.dart';

// Future openBox() async{
//   final appDocumentDir = await getApplicationDocumentsDirectory();
//   await Hive.initFlutter(appDocumentDir.path);
//   Hive.registerAdapter(BlogAdapter());
//   var box= await Hive.openBox('blogs');
//   return;
// }
//
// getAllData() async{
//   await openBox();
//
//   final String apiUrl = 'https://intent-kit-16.hasura.app/api/rest/blogs';
//   final String apiKey = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';
//
//
//   try{
//     var response= await http.get(
//         Uri.parse(apiUrl),
//         headers: {
//         'x-hasura-admin-secret': apiKey,
//         },
//     );
//     var _jsondecode=jsonDecode(response.body);
//   }catch(SocketException){
//     print("No Internet");
//   }
//
// }
//
// Future putData() async{
//
// }
class BlogRepository {
  //final _myBox= Hive.box('blogs');
  final String apiUrl = 'https://intent-kit-16.hasura.app/api/rest/blogs';
  final String apiKey = '32qR4KmXOIpsGPQKMqEJHGJS27G5s7HdSKO3gdtQd2kv5e852SiYwWNfxkZOBuQ6';

  Future<List<dynamic>> fetchBlogs() async {
    final response = await http.get(
      Uri.parse(apiUrl),
      headers: {
        'x-hasura-admin-secret': apiKey,
      },
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      final List<dynamic> blogs = data['blogs'] as List<dynamic>;
      return blogs;
    } else {
      throw Exception('Failed to load blogs');
    }
  }
}
