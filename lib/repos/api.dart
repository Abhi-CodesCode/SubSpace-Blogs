import 'dart:convert';
import 'package:http/http.dart' as http;

class BlogRepository {
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
