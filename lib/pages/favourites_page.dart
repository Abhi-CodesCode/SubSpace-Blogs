import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:lottie/lottie.dart';
import 'package:subspace_blog/widgets/post_widget.dart';
import '../repos/api.dart';
import '../repos/bookmark_manager.dart';

import 'article_page.dart';

class FavouritesPage extends StatefulWidget {
  const FavouritesPage({super.key});

  @override
  State<FavouritesPage> createState() => _FavouritesPageState();
}

class _FavouritesPageState extends State<FavouritesPage> {
  @override
  Widget build(BuildContext context) {
    List<String> bookmarkedIds = BookmarkManager.getBookmarkedIds();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Your Favourites",
          style: GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 26),
        ),
      ),
      body: FutureBuilder<List<dynamic>>(
        future: BlogRepository().fetchBlogs(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Lottie.asset(
                'assets/loader.json',
                width: 260,
                height: 200,
                fit: BoxFit.fill,
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Failed to load blogs'));
          } else if (snapshot.hasData) {
            List<dynamic> blogs = snapshot.data!;
            List<dynamic> bookmarkedBlogs = blogs.where((blog) {
              return bookmarkedIds.contains(blog['id'].toString()); // Convert API ID to String
            }).toList();

            if (bookmarkedBlogs.isEmpty) {
              return Center(child: Text('No bookmarks found.'));
            }

            return ListView.builder(
              itemCount: bookmarkedBlogs.length,
              itemBuilder: (context, index) {
                var blog = bookmarkedBlogs[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ArticlePage(
                          src: blog['image_url'],
                          title: blog['title'],
                          tag: blog['id'],
                          id: blog['id'],
                        ),
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0,right: 20,bottom: 10),
                    child: Row(
                      children: [
                     blog['image_url'] != null
                      ? SizedBox(
                      width: 140,  // Fixed width for the leading widget
                      height: 140,  // Fixed height for the leading widget
                      child: Image.network(
                          blog['image_url'],
                          loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                            if (loadingProgress == null) {
                              return child;
                            } else {
                              return Center(
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes != null
                                      ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                                      : null,
                                ),
                              );
                            }
                          },

                      errorBuilder: (context, error, stackTrace) {
                        return Icon(Icons.error, size: 50);  // Placeholder in case of an error
                      },
                    ),
                     ): SizedBox(
                       width: 50,
                       height: 50,
                       child: Placeholder(),  // Placeholder widget if image_url is null
                     ),
                        SizedBox(width: 20,),
                        Expanded(child: Column(
                          children: [
                            Divider(height: 30,),
                            Text(blog['title'],style: GoogleFonts.poppins(fontSize: 16),),
                            Divider(height: 30,)
                          ],
                        ))
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text('No data available'));
          }
        },
      ),
    );
  }
}
