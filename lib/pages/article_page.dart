import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../repos/bookmark_manager.dart';

class ArticlePage extends StatefulWidget {
  final String src;
  final String title;
  final String tag;
  final String id;
  const ArticlePage({super.key, required this.src, required this.title, required this.tag, required this.id});

  @override
  State<ArticlePage> createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  bool isBookmarked = false;

  @override
  void initState() {
    super.initState();
    // Check if the post is already bookmarked
    if (BookmarkManager.isBookmarked(widget.id)) {
      setState(() {
        isBookmarked = true;
      });
    }
  }

  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
    if (isBookmarked) {
      BookmarkManager.addBookmark(widget.id);
    } else {
      BookmarkManager.removeBookmark(widget.id);
    }
  }
  @override
  Widget build(BuildContext context) {

    String description="Lorem ipsum dolor sit amet, consectetur adipiscing elitur scelerisque tristique. Quisque pharetra, mi in interdum accumsan, enim tellus feugiat ante, a ultrices purus dui eget quam. Curabitur eu auctor metus. Aenean vitae felis eu lectus tempus sodales non vitae lacus. Curabitur nec egestas arcu. Donec erat diam, feugiat at mauris id, egestas fermentum arcu. Suspendisse potenti. Nam eleifend urna massa, eget mattis nisi sodales a. Cras eleifend ipsum tortor, semper iaculis ligula mattis id.Nulla facilisi. Aenean quis molestie magna. Suspendisse potenti. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Fusce sodales ultricies purus ac auctor. Aliquam nunc urna, finibus nec facilisis in, bibendum vel elit. Nam leo lectus, condimentum ac odio eget, faucibus porta felis. Fusce nec neque sit amet metus pulvinar vulputate. Ut rutrum massa blandit urna congue mattis. Mauris vitae enim non magna accumsan scelerisque id in nisi.Vivamus turpis sem, maximus luctus malesuada ac, placerat in nisl. Fusce at diam dapibus, suscipit magna quis, porta diam. Nulla facilisi. Duis placerat aliquet tellus, ut porta nibh vestibulum eu. Cras nec bibendum eros, at fringilla purus. Nulla tristique consequat neque eget consequat. Aliquam imperdiet fermentum convallis. Nunc orci mi, laoreet nec convallis vel, consectetur eget dolor. Class aptent taciti sociosqu ad litora torquent per conubia nostra, per inceptos himenaeos. Cras hendrerit nulla efficit.";
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Hero(
                tag: widget.tag,
                child: Image.network(widget.src,fit: BoxFit.fill,width: double.maxFinite,filterQuality: FilterQuality.high,)),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                  SizedBox(height: 20,),

                  Text(widget.title,style: GoogleFonts.poppins(fontSize: 26,fontWeight: FontWeight.w700),),
                  Divider(color: Colors.black,thickness: 1.5, height: 30,),
                  Text(description,style: GoogleFonts.notoSans(fontSize: 16),),
                ],
              ),
            )
          ],
        ),

      ),

      floatingActionButton: FloatingActionButton(
        highlightElevation: 20,
        shape: CircleBorder(side: BorderSide(color: Colors.white,strokeAlign: BorderSide.strokeAlignOutside)),
        backgroundColor: Colors.white,
        onPressed: toggleBookmark,
        child: Icon(isBookmarked?Icons.bookmark:Icons.bookmark_border_outlined, color: Colors.black,),
      ),

      bottomNavigationBar:  BottomAppBar(
        shadowColor: Colors.grey,
        color:Colors.white38,
        elevation: 1,
        notchMargin: 6,
        height: 60,
        shape: const CircularNotchedRectangle(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal:30.0),
          // child: Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     IconButton(
          //       icon: Icon(Icons.report_problem_rounded),
          //       onPressed: () {
          //
          //       },
          //     ),
          //     IconButton(
          //       icon: Icon(Icons.share_outlined),
          //       onPressed: () {
          //         // Add your share action here
          //       },
          //     ),
          //   ],
          // ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
    );
  }
}
