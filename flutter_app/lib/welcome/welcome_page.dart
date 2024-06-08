import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/api/my_api.dart';
// import 'package:flutter_app/auth/auth_page.dart';
import 'package:flutter_app/models/get_article_info.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_app/signup_login/sign_in.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  var articles = <ArticleInfo>[];
  var _totalDots = 1;
  double _currentPosition = 0.0;

  @override
  void initState() {
    super.initState();
    _initData();
  }

  double _validPosition(double position) {
    if (position >= _totalDots) return 0;
    if (position < 0) return _totalDots - 1.0;
    return position;
  }

  void _updatePosition(double position) {
    setState(() => _currentPosition = _validPosition(position));
  }

  Widget _buildRow(List<Widget> widgets) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: widgets,
      ),
    );
  }

  String getCurrentPositionPretty() {
    return (_currentPosition + 1.0).toStringAsPrecision(2);
  }

  Future<void> _initData() async {
    var response = await CallApi().getPublicData("welcome-info");
    if (response != null && mounted) {
      setState(() {
        Iterable list = json.decode(response.body);
        print("API Response: $list"); // Debugging print statement
        articles = list.map((model) => ArticleInfo.fromJson(model)).toList();
        print("Parsed Articles: $articles"); // Debugging print statement
        _totalDots = articles.isNotEmpty ? articles.length : 1;
      });
    } else {
      print('Failed to load data or response is null');
    }
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentPosition = _currentPosition.ceilToDouble();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF333d94),
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("img/background.png"),
                fit: BoxFit.fill,
              ),
            ),
          ),
          articles.isEmpty
              ? const CircularProgressIndicator() // Show a loading indicator when articles are being fetched
              : _buildRow([
                  Padding(
                    padding: const EdgeInsets.only(top: 16.0), // Adjust the top padding value as needed
                    child: DotsIndicator(
                      dotsCount: _totalDots,
                      position: _currentPosition.round(),
                      axis: Axis.horizontal,
                      decorator: DotsDecorator(
                        size: const Size.square(9.0),
                        activeSize: const Size(18.0, 9.0),
                        activeShape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                      onTap: (pos) {
                        setState(() => _currentPosition = pos.toDouble());
                      },
                    ),
                  ),
                ]),
          Container(
            height: 180,
            color: const Color(0xFF333d94),
            child: articles.isEmpty
                ? const Center(child: Text("No articles available", style: TextStyle(color: Colors.white)))
                : PageView.builder(
                    onPageChanged: _onPageChanged,
                    controller: PageController(viewportFraction: 1.0),
                    itemCount: articles.length,
                    itemBuilder: (_, i) {
                      return Container(
                        height: 180,
                        padding: const EdgeInsets.only(top: 50, left: 50, right: 50),
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.only(right: 10),
                        child: Text(
                          articles[i].article_content != null ? articles[i].article_content! : "No content available",
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontFamily: "Avenir",
                              fontWeight: FontWeight.w400),
                        ),
                      );
                    },
                  ),
          ),
          Expanded(
            child: Stack(
              children: [
                Positioned(
                  height: 50,
                  bottom: 30,
                  left: (MediaQuery.of(context).size.width - 200) / 2,
                  right: (MediaQuery.of(context).size.width - 200) / 2,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const SignIn()),
                      );
                    },
                    child: Container(
                      height: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        color: const Color(0xFF7179ed),
                      ),
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Get Started',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
