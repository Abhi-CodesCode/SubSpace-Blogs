import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PostWidget extends StatelessWidget {
  final String src;
  final String title;
  final String tag;
  const PostWidget({super.key, required this.src, required this.title, required this.tag});

  @override
  Widget build(BuildContext context) {
    String description="Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla condimentum est sit amet pharetra dictum. Aenean pharetra tellus justo, et hendrerit justo consectetur eget. Integer viverra erat mi, et sagittis massa scelerisque tristique. Quisque pharetra, mi in interdum accumsan, enim tellus feugiat ante, a ultrices purus dui eget quam. Curabitur eu auctor metus. Aenean vitae felis.";
    return  Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Hero(
            tag: tag,
            child: SizedBox(width:double.maxFinite,child: Image.network(
              src,
              fit: BoxFit.cover,
              filterQuality: FilterQuality.high,loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child; // Image is loaded, return the image
              } else {
                return Center(
                  child: CircularProgressIndicator(
                    value: loadingProgress.expectedTotalBytes != null
                        ? loadingProgress.cumulativeBytesLoaded / (loadingProgress.expectedTotalBytes ?? 1)
                        : null,
                  ),
                ); // Return a loading indicator while the image is loading
              }
            },)),
          ),
          SizedBox(height: 30,),
          Divider(color: Colors.black,thickness: 1.2, height: 30),
          Text(title,style: GoogleFonts.poppins(fontSize: 26,fontWeight: FontWeight.w700),),
          Divider(color: Colors.grey,thickness: 1.2, height: 30),
          Text(description,style: GoogleFonts.notoSans(fontSize: 16),),
          Divider(color: Colors.black,thickness: 1, height: 60),
        ],
      ),
    );
  }
}