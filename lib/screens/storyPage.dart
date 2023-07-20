import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class StoryPage extends StatefulWidget {
  String storyName;
  String storyImg;
  String storyText;
  StoryPage(
      {super.key,
      required this.storyImg,
      required this.storyName,
      required this.storyText});
  @override
  State<StoryPage> createState() => _StoryPageState();
}

class _StoryPageState extends State<StoryPage> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    // TODO: implement build
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent, // 1
        elevation: 0, // 2

        title: Stack(
          children: [
            Text(
              widget.storyName,
              style: TextStyle(
                fontSize: 20,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 3
                  ..color = Colors.black,
                fontFamily: "Kalam",
              ),
            ),
            Text(
              widget.storyName,
              style: TextStyle(
                  fontSize: 20,
                  letterSpacing: 1,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "Kalam"),
            ),
          ],
        ),
      ),
      body: _bodWidget(screenSize),
    );
  }

  _bodWidget(Size screenSize) {
    return SingleChildScrollView(
      child: Center(
        child: Stack(
          children: [
            Container(
              height: screenSize.height,
              width: screenSize.width,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/arkaplan.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 85, left: 35, right: 35, bottom: 5),
                  child: Container(
                    width: screenSize.width / 0.4,
                    height: screenSize.height / 3.8,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(widget.storyImg),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.black, width: 2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 7,
                          spreadRadius: 2,
                          offset: Offset(5, 6),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 27),
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/cerceve.png"),
                          fit: BoxFit.fill),
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          blurRadius: 7,
                          spreadRadius: 2,
                          offset: Offset(5, 6),
                        ),
                      ],
                    ),
                    height: screenSize.height / 1.8,
                    width: screenSize.width / 1.1,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        top: 20,
                        left: 10,
                        bottom: 25,
                      ),
                      child: SingleChildScrollView(
                          child: Padding(
                        padding: const EdgeInsets.all(30),
                        child: Column(
                          children: [
                            Center(
                              child: Text(widget.storyName,
                                  style: TextStyle(
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Kalam",
                                      color: Colors.amber.shade400)),
                            ),
                            Text(widget.storyText,
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "Kalam")),
                          ],
                        ),
                      )),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
