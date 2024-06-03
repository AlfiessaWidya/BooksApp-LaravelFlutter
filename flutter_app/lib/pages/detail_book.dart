import 'package:flutter/material.dart';
import 'package:flutter_app/components/text_widget.dart';
import 'package:flutter_app/models/get_article_info.dart';

import 'all_books.dart';

class DetailBookPage extends StatefulWidget {
  final ArticleInfo articleInfo;
  final int index;

  const DetailBookPage({Key? key, required this.articleInfo, required this.index}) : super(key: key);

  @override
  _DetailBookPageState createState() => _DetailBookPageState();
}

class _DetailBookPageState extends State<DetailBookPage> {
  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: Colors.white,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Colors.white,
          // appBar: AppBar(
          //   toolbarHeight: 30,
          //   backgroundColor: Color(0xFFffffff),
          //   elevation: 0.0,
          // ),
          body: Container(
            color: Colors.white,
            padding: const EdgeInsets.only(left: 10),
            child: Column(
              children: [
                SizedBox(height: 15),
                Container(
                  padding: const EdgeInsets.only(left: 0, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                        icon: Icon(Icons.arrow_back_ios, color: Color(0xFF363f93)),
                        onPressed: () => Navigator.pop(context),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(left: 15),
                  child: Row(
                    children: [
                      Material(
                        elevation: 0.0,
                        child: Container(
                          height: 180,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: Offset(0, 3),
                              )
                            ],
                            image: DecorationImage(
                              image: NetworkImage("http://192.168.18.13:8000/uploads/${widget.articleInfo.img}"),
                              fit: BoxFit.fill,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: screenWidth - 30 - 140 - 30,
                        margin: const EdgeInsets.only(left: 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10),
                            TextWidget(text: widget.articleInfo.title, fontSize: 26),
                            TextWidget(text: "Author: Dylan Ahmed", fontSize: 18, color: Color(0xFF7b8ea3)),
                            Divider(color: Colors.grey),
                            TextWidget(text: widget.articleInfo.title, fontSize: 12, color: Color(0xFF7b8ea3)),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(height: 40),
                // Container(
                //   padding: const EdgeInsets.only(right: 20, left: 15),
                //   child: Row(
                //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
                //     children: [
                //       Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: <Widget>[
                //           Icon(Icons.favorite, color: Color(0xFF7b8ea3), size: 22),
                //           SizedBox(width: 10),
                //           TextWidget(text: "Like", fontSize: 16),
                //         ],
                //       ),
                //       Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: <Widget>[
                //           Icon(Icons.share, color: Color(0xFF7b8ea3), size: 22),
                //           SizedBox(width: 10),
                //           TextWidget(text: "Share", fontSize: 16),
                //         ],
                //       ),
                //       Row(
                //         mainAxisSize: MainAxisSize.min,
                //         children: <Widget>[
                //           Icon(Icons.bookmarks_sharp, color: Color(0xFF7b8ea3), size: 22),
                //           SizedBox(width: 10),
                //           TextWidget(text: "Bookself", fontSize: 16),
                //         ],
                //       )
                //     ],
                //   ),
                // ),
                SizedBox(height: 10),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 15), // Adjust padding as needed
                      child: TextWidget(text: "Details", fontSize: 26),
                    ),
                    Expanded(child: Container()),
                  ],
                ),
                SizedBox(height: 10),
                Container(
                  height: 200,
                  padding: EdgeInsets.only(left: 15, right: 15),
                  child: TextWidget(text: widget.articleInfo.article_content, fontSize: 16, color: Colors.grey),
                ),
                GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AllBooks()));
                },
                child: Container(
                  padding: const EdgeInsets.only(right: 20, left: 15),
                  margin: const EdgeInsets.only(top: 70),
                  color: Colors.transparent, // Ensure the container is tappable
                  child: Row(
                    children: [
                      TextWidget(text: "Check the directory", fontSize: 20),
                      Expanded(child: Container()),
                      Icon(Icons.arrow_forward_ios),
                    ],
                  ),
                ),
              ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
