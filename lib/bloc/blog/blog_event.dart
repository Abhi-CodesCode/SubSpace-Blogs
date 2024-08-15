import 'package:meta/meta.dart';

@immutable
abstract class BlogEvent {}

class FetchBlogs extends BlogEvent {}
