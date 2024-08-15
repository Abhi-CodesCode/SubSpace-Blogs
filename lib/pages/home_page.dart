import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:subspace_blog/widgets/post_widget.dart';
import '../bloc/blog/blog_bloc.dart';
import '../bloc/blog/blog_event.dart';
import '../bloc/blog/blog_state.dart';
import '../bloc/category/category_cubit.dart';
import '../constants/lists.dart';
import '../repos/api.dart';
import 'article_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        toolbarHeight: 100,
        title: Image.asset("assets/SubSpace2.png",fit: BoxFit.fitWidth,width: 200)
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {  },child: Icon(Icons.bookmark,color: Colors.black,size: 26,),),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => CategoryCubit(),
          ),
          BlocProvider(
            create: (context) => BlogBloc(blogRepository: BlogRepository())..add(FetchBlogs()),
          ),
        ],
        child: BlocBuilder<BlogBloc, BlogState>(
          builder: (BuildContext context, state) {
            if (state is BlogLoading) {
              return Center(
                child: Lottie.asset(
                  'assets/loader.json',
                  width: 260,
                  height: 200,
                  fit: BoxFit.fill,
                ),
              );
            } else if (state is BlogLoaded) {
              return Column(
                children: [
                  BlocBuilder<CategoryCubit, int>(
                    builder: (context, selectedIndex) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 16, right: 8, bottom: 10),
                          child: Wrap(
                            spacing: 8,
                            children: List<Widget>.generate(
                              categoryList.length,
                                  (int index) {
                                bool isSelected = selectedIndex == index;
                                return Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    ChoiceChip.elevated(
                                      showCheckmark: false,
                                      label: Text(categoryList[index]),
                                      selected: isSelected,
                                      onSelected: (bool selected) {
                                        context.read<CategoryCubit>().selectCategory(
                                            selected ? index : 0);
                                      },
                                    ),
                                    if (isSelected)
                                      Container(
                                        height: 2, // Height of the underline
                                        width: 50, // Width of the underline (adjust based on your needs)
                                        color: Colors.black, // Color of the underline
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),

                        ),
                      );
                    },
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.blogs.length-1,
                      itemBuilder: (context, index) {
                        final blog = state.blogs[index+1];
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ArticlePage(
                                  title: blog['title'],
                                  src: blog['image_url'],
                                ),
                              ),
                            );
                          },
                          child: PostWidget(
                            title:blog['title'],
                            src: blog['image_url'],
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            } else if (state is BlogError) {
              return Center(child: Text(state.message));
            }
            return Text("Restart the App!");
          },
        ),
      ),
    );
  }
}