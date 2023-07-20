import 'package:admob_flutter/admob_flutter.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutterdeneme1/screens/storyPage.dart';

//ca-app-pub-8937226909637905/7694991686
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => HomePageState();
}

class HomePageState extends State<HomePage> {
  List<Widget> storyWidgetList = [];
  late AdmobInterstitial interstitialAd;
  var counter = 0;
  @override
  void initState() {
    super.initState();

    interstitialAd = AdmobInterstitial(
      adUnitId: "ca-app-pub-8937226909637905/7694991686",
      listener: (AdmobAdEvent event, Map<String, dynamic>? args) {
        if (event == AdmobAdEvent.closed) interstitialAd.load();
      },
    );

    interstitialAd.load();
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent, // 1
        elevation: 0, // 2
        title: Stack(
          children: [
            Text(
              'Stories',
              style: TextStyle(
                fontSize: 30,
                letterSpacing: 5,
                fontWeight: FontWeight.bold,
                foreground: Paint()
                  ..style = PaintingStyle.stroke
                  ..strokeWidth = 3
                  ..color = Colors.black,
                fontFamily: "Kalam",
              ),
            ),
            Text(
              'Stories',
              style: TextStyle(
                  fontSize: 30,
                  letterSpacing: 5,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: "Kalam"),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: _bodyWidget(screenSize),
    );
  }

  _bodyWidget(Size screenSize) {
    return FutureBuilder<dynamic>(
        future: getData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return spinkit;
          } else {
            if (snapshot.hasError)
              return Center(child: Text('Check Your Internet Connection'));

            return Stack(
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
                GridView.count(
                    padding: const EdgeInsets.only(
                        top: 80, left: 20, right: 20, bottom: 20),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    crossAxisCount: 2,
                    childAspectRatio: 0.60,
                    children: storyWidgetList.toList()),
              ],
            );
          }
        });
  }

  myCardWidget(String imageUrl, String storyTitle, String storyText) {
    return InkWell(
      onTap: () async {
        counter++;

        final isLoaded = await interstitialAd.isLoaded;
        print(counter);
        if (isLoaded == true && counter % 2 == 0) {
          interstitialAd.show();
        } else {
          print('Interstitial ad is still loading...');
        }

        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => StoryPage(
                storyImg: imageUrl,
                storyName: storyTitle,
                storyText: storyText,
              ),
            ));
      },
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            image: DecorationImage(
                image: NetworkImage(imageUrl), fit: BoxFit.cover),
            color: Colors.cyan,
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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: Color.fromRGBO(109, 195, 182, 30),
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
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      storyTitle,
                      style: TextStyle(
                          fontFamily: "Kalam",
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }

  Future getData() async {
    storyWidgetList.clear();
    await FirebaseFirestore.instance
        .collection("stories")
        .get()
        .then((value) => {
              value.docs.forEach((element) {
                var storyName = element.data()["storyName"];
                var storyImg = element.data()["storyImg"];
                var storyText = element.data()["storyText"];

                storyWidgetList.add(
                  myCardWidget(storyImg, storyName, storyText),
                );
              })
            });
  }

  final spinkit = SpinKitFadingCircle(
    size: 100,
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: index.isEven ? Colors.cyan : Colors.greenAccent,
        ),
      );
    },
  );
}
