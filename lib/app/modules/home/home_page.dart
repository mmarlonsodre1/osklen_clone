import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:osklen/app/modules/home/model/carousel_model.dart';
import 'package:osklen/app/modules/home/pages/first_carousel.dart';
import 'package:osklen/app/modules/home/pages/second_carousel.dart';
import 'package:osklen/components/buttons.dart';
import 'package:osklen/components/menu/top_menu.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _scrollController = ScrollController();
  double scrollPosition = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          NotificationListener(
            onNotification: (t) {
              if (t is ScrollNotification) {
                setState(() {
                  scrollPosition = _scrollController.position.pixels;
                });
              }
              return true;
            },
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  const FirstCarousel(),
                  const SecondCarousel(),
                  SizedBox(height: 100.h,)
                ],
              ),
            ),
          ),
          TopMenu(scrollPosition: scrollPosition),
        ],
      ),
    );
  }
}