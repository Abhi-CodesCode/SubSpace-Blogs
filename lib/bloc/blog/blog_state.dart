import 'package:meta/meta.dart';

@immutable
abstract class BlogState {}

class BlogInitial extends BlogState {}

class BlogLoading extends BlogState {}

class BlogLoaded extends BlogState {
  final List<dynamic> blogs;

  BlogLoaded({required this.blogs});
}

class BlogError extends BlogState {
  final String message;

  BlogError({required this.message});
}