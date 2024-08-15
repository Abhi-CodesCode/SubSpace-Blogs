import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:subspace_blog/pages/home_page.dart';

void main()=>runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.light(primary: Colors.white,shadow: Colors.transparent,secondary: Colors.white),
        primarySwatch: Colors.grey,
        brightness: Brightness.light,

        scaffoldBackgroundColor: Colors.white,
        primaryColor: Colors.black,

      ),
    );
  }
}
