import 'dart:convert';
import 'dart:ui';
import 'package:flappy_search_bar_ns/flappy_search_bar_ns.dart' as search_bar_ns;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_app/api/my_api.dart';
import 'package:flutter_app/components/text_widget.dart';
import 'package:flutter_app/models/get_article_info.dart';
import 'package:flutter_app/pages/all_books.dart';
import 'package:flutter_app/signup_login/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'detail_book.dart';

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  var articles = <ArticleInfo>[];
  var allarticles = <ArticleInfo>[];
  String username = '';

  @override
  void initState() {
    _getArticles();
    super.initState();
  }
  
  _getArticles() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var userJson = localStorage.getString("user");
    if (userJson != null) {
      var user = json.decode(userJson);
      setState(() {
        username = user['name'];
      });
    }

    await _initData();
  }
  
  _initData() async {
    try {
      var recommendedResponse = await CallApi().getPublicData("recommendedarticles");
      if (recommendedResponse != null && recommendedResponse.body != null) {
        setState(() {
          Iterable list = json.decode(recommendedResponse.body);
          articles = list.map((model) => ArticleInfo.fromJson(model)).toList();
        });
      } else {
        // Handle null response or body
        debugPrint('Recommended articles response or body is null');
      }

      var allArticlesResponse = await CallApi().getPublicData("allarticles");
      if (allArticlesResponse != null && allArticlesResponse.body != null) {
        setState(() {
          Iterable list = json.decode(allArticlesResponse.body);
          allarticles = list.map((model) => ArticleInfo.fromJson(model)).toList();
        });
      } else {
        // Handle null response or body
        debugPrint('All articles response or body is null');
      }
    } catch (e) {
      // Handle any errors that occur during the API call
      debugPrint('An error occurred while fetching articles: $e');
    }
  }

  Future<List<ArticleInfo>> search(String? search) async {
    if (search == null || search.isEmpty) {
      return [];
    }
    await Future.delayed(Duration(seconds: 2)); // simulate a delay
    return allarticles.where((article) => article.title.toLowerCase().contains(search.toLowerCase())).toList();
  }
  
  @override
  Widget build(BuildContext context) {
  final double height = MediaQuery.of(context).size.height;
  final double width = MediaQuery.of(context).size.width;
  

  debugPrint(height.toString());

  return Scaffold(
    backgroundColor: const Color(0xFFFFFFFF),
    // appBar: AppBar(
    //   toolbarHeight: 30,
    //   backgroundColor: const Color(0xFFFFFFFF),
    //   elevation: 0.0,
    // ),
    body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 40),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AllBooks()));
                  },
                  child: Icon(Icons.menu_book_sharp, color: Color(0xFF363f93)),
                ),
                PopupMenuButton<String>(
      icon: Icon(Icons.menu, color: Color(0xFF363f93)),
      onSelected: (String result) {
        if (result == 'logout') {
          // Implementasi log out di sini
          // Misalnya, bisa menampilkan dialog konfirmasi log out
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text("Log Out"),
                content: Text("Are you sure you want to log out?"),
                actions: [
                  TextButton(
                    child: Text("Cancel"),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                  TextButton(
                    child: Text("Log Out", style: TextStyle(color: Color(0xFF363f93), fontSize: 16)),
                    onPressed: () {
                      // Tambahkan logika log out di sini
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      );
                    },
                  ),
                ],
              );
            },
          );
        }
      },
      itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
        const PopupMenuItem<String>(
          value: 'logout',
          child: Text('Log Out'),
        ),
      ],
    ),
              ],
            ),
          ),
          SizedBox(height: height * 0.03),
          Container(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextWidget(
                  text: "Hallo,",
                  fontSize: 26,
                  isUnderLine: false,
                ),
                SizedBox(width: 5), // Add some spacing between the texts
                if (username.isNotEmpty)
                  TextWidget(
                    text: username,
                    fontSize: 22,
                    isUnderLine: false,
                  ),
                Expanded(child: Container()),
              ],
            ),
          ),
          SizedBox(height: 2),
          Container(
            height: 80,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: search_bar_ns.SearchBar<ArticleInfo>(
                onSearch: search,
                onItemFound: (ArticleInfo? articles, int index) {
                  if (articles == null) {
                    return const ListTile(
                      title: Text('No book found'),
                    );
                  }
                  return ListTile(
                    title: Text(articles.title),
                    subtitle: Text(articles.author ?? "Unknown author"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => DetailBookPage(articleInfo: articles, index: index)
                        )
                      );
                    },
                  );
                }
              ),
            ),
          ),
          const SizedBox(height: 5,),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(text: "Recommended", fontSize: 26,),
                Expanded(child: Container()),
                Row(
                  children: [
                    TextWidget(text: "view all", fontSize: 12, color: Color(0xFFa9b3bd)),
                    IconButton(
                      onPressed: () => {

                      },
                      icon: Icon(Icons.arrow_forward_ios, color: Color(0xFF363f93), size: 16),
                    )
                  ],
                )
              ],
            ),
          ),
          const SizedBox(height: 3),
          SizedBox(
            height: height * 0.22,
            child: PageView.builder(
              controller: PageController(viewportFraction: .9),
              itemCount: articles.length,
              itemBuilder: (_, i){
                return GestureDetector(
                  onTap: () {
                    debugPrint(i.toString());
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>DetailBookPage(articleInfo: articles[i], index: i)),
                    );
                  },
                  child: articles.isEmpty ? const CircularProgressIndicator() : Stack(
                    children: [
                      Positioned(
                        top: 35,
                        child: Material(
                          elevation: 0.0,
                          child: Container(
                            height: 180.0,
                            width: width * 0.85,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  offset: const Offset(-10.0, 0.0),
                                  blurRadius: 20.0,
                                  spreadRadius: 4.0,
                                )
                              ]
                            ),
                          ),
                        )
                      ),
                      Positioned(
                        top: 0.0,
                        left: 0,
                        child: Card(
                          elevation: 0.0,
                          shadowColor: Colors.grey.withOpacity(0.25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Container(
                            height: 200,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                fit:BoxFit.fill,
                                image: NetworkImage("http://192.168.18.13:8000/uploads/"+articles[i].img.toString())
                              )
                            ),
                          ),
                          
                        ),
                      ),
                      Positioned(
                        top: 15.0,
                        left: width * 0.43,
                        child: Container(
                          height: 200,
                          width: width * 0.45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: articles[i].title,
                                fontSize: 22,
                              ),
                              TextWidget(
                                color: Colors.grey,
                                text: articles[i].author==null?"Dylan":articles[i].author,
                                fontSize: 12,
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              Text(
                                articles[i].description,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      )
                    ]
                  )
                );
              }
            )
          ),
          const SizedBox(height: 30),
          Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(
                  text: "New Book List",
                  fontSize: 26,
                ),
                Row(
                  children: [
                    TextWidget(text: "view all", fontSize: 12, color: Color(0xFFa9b3bd)),
                    IconButton(
                      onPressed: () => {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => AllBooks()))
                      },
                      icon: Icon(Icons.arrow_forward_ios, color: Color(0xFF363f93), size: 16),
                    )
                  ],
                )
              ],
            ),
          ),
           const SizedBox(height: 3),
          SizedBox(
            height: height * 0.22,
            child: PageView.builder(
              controller: PageController(viewportFraction: .9),
              itemCount: articles.length,
              itemBuilder: (_, i){
                return GestureDetector(
                  onTap: () {
                    debugPrint(i.toString());
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context)=>DetailBookPage(articleInfo: allarticles[i], index: i)),
                    );
                  },
                  child: allarticles.isEmpty ? const CircularProgressIndicator() : Stack(
                    children: [
                      Positioned(
                        top: 35,
                        child: Material(
                          elevation: 0.0,
                          child: Container(
                            height: 180.0,
                            width: width * 0.45,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0.0),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.3),
                                  offset: const Offset(-10.0, 0.0),
                                  blurRadius: 20.0,
                                  spreadRadius: 4.0,
                                )
                              ]
                            ),
                          ),
                        )
                      ),
                      Positioned(
                        top: 0.0,
                        left: 0,
                        child: Card(
                          elevation: 0.0,
                          shadowColor: Colors.grey.withOpacity(0.25),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)
                          ),
                          child: Container(
                            height: 200,
                            width: 150,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              image: DecorationImage(
                                fit:BoxFit.fill,
                                image: NetworkImage("http://192.168.18.13:8000/uploads/"+allarticles[i].img.toString())
                              )
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        top: 15.0,
                        left: width * 0.43,
                        child: Container(
                          height: 200,
                          width: width * 0.45,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextWidget(
                                text: allarticles[i].title,
                                fontSize: 22,
                              ),
                              TextWidget(
                                color: Colors.grey,
                                text: allarticles[i].author==null?"Dylan":articles[i].author,
                                fontSize: 12,
                              ),
                              Divider(
                                color: Colors.black,
                              ),
                              Text(
                                allarticles[i].description,
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 12,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      )
                    ]
                  )
                );
              }
            )
          )
        ],
      ),
    ),
  );
}
}
