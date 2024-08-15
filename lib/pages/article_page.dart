import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ArticlePage extends StatelessWidget {
  final String src;
  final String title;
  const ArticlePage({super.key, required this.src, required this.title});

  @override
  Widget build(BuildContext context) {
    String description="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla condimentum est sit amet pharetra dictum. Aenean pharetra tellus justo, et hendrerit justo consectetur eget. Integer viverra erat mi, et sagittis massa scelerisque tristique. Quisque pharetra, mi in interdum accumsan, enim tellus feugiat ante, a ultrices purus dui eget quam. Curabitur eu auctor metus. Aenean vitae felis.";

    return Scaffold(
      body: Column(
        children: [
          Image.network(src,fit: BoxFit.fill,width: double.maxFinite,filterQuality: FilterQuality.high,height: 260,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14.0),
            child: Column(
              children: [
                SizedBox(height: 30,),
                Text(title,style: GoogleFonts.poppins(fontSize: 26,fontWeight: FontWeight.w700),),
                Divider(color: Colors.black,thickness: 1.5, height: 30),
                Text(description,style: GoogleFonts.notoSans(fontSize: 16),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
