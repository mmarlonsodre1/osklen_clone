import 'package:flutter/material.dart';
import 'package:osklen/components/menu/top_menu.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final PageController _pageController = PageController();
  late VideoPlayerController _videoController;

  @override
  void initState() {
    _loadVideoPlayer();

    _controller = AnimationController(
        duration: const Duration(seconds: 6), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          var page = _pageController.page?.round() ?? 0;
          if (page + 1 == 1) {
            _videoController.play();
          } else {
            _videoController.pause();
          }

          if (page < 2) {
            _pageController.jumpToPage(page + 1);
          } else {
            _pageController.jumpToPage(0);
          }
          _controller.reset();
          _controller.forward();
        }
      });
    _controller.forward();

    super.initState();
  }

  void _loadVideoPlayer(){
    _videoController = VideoPlayerController.asset('assets/videos/vd_carousel2.mp4');
    _videoController.addListener(() {
      setState(() {});
    });
    _videoController.initialize().then((value){
      setState(() {});
    });
    _videoController.setLooping(true);
  }

  @override
  void dispose() {
    _controller.stop();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _pager(),
          _pagerListLoading(),
          const TopMenu(),
        ],
      ),
    );
  }

  Widget _pagerListLoading() {
    return Padding(
      padding: EdgeInsets.only(bottom: 5.h),
      child: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _pagerLoading(0),
            SizedBox(width: 2.w,),
            _pagerLoading(1),
            SizedBox(width: 2.w,),
            _pagerLoading(2),
            SizedBox(width: 2.w,),
            _pagerLoading(3),
          ],
        ),
      ),
    );
  }

  Widget _pagerLoading(int index) {
    var page = 0;
    try { page = _pageController.page?.round() ?? 0; } catch(_) {}

    return SizedBox(
      width: 5.w,
      child: LinearProgressIndicator(
        minHeight: 2,
        color: Colors.white,
        value: index == page ? _animation.value : 0,
        semanticsLabel: 'null',
      ),
    );
  }

  Widget _pager() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Image.asset(
          'assets/images/img_carousel1.webp',
          height: 100.h,
          width: 100.w,
          fit: BoxFit.fill,
        ),
        SizedBox(
          height: 100.h,
          width: 100.w,
          child: VideoPlayer(_videoController),
        ),
        Image.asset(
          'assets/images/img_carousel3.webp',
          height: 100.h,
          width: 100.w,
          fit: BoxFit.fill,
        ),
        Image.asset(
          'assets/images/img_carousel4.webp',
          height: 100.h,
          width: 100.w,
          fit: BoxFit.fill,
        ),
      ],
    );
  }
}