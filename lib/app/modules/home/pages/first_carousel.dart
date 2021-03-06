import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:osklen/app/modules/home/model/carousel_model.dart';
import 'package:osklen/components/buttons.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class FirstCarousel extends StatefulWidget {
  const FirstCarousel({Key? key}) : super(key: key);

  @override
  State<FirstCarousel> createState() => _FirstCarouselState();
}

class _FirstCarouselState extends State<FirstCarousel> with TickerProviderStateMixin {
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
          _goToPage(null);
          _controller.reset();
          _controller.forward();
        }
      });
    _controller.forward();

    super.initState();
  }

  void _goToPage(int? index) {
    var page = index ?? _pageController.page?.round() ?? 0;
    if (page + 1 == 1) {
      _videoController.play();
    } else {
      _videoController.pause();
    }

    if (page <= 2) {
      _pageController.jumpToPage(page + 1);
    } else {
      _pageController.jumpToPage(0);
    }
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
    _controller.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100.h,
      width: 100.w,
      child: Stack(
        children: [
          _pager(),
          _pagerListLoading(),
          _pagerInformation(),
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

    return GestureDetector(
      onTap: () => _goToPage(index - 1),
      child: SizedBox(
        width: 5.w,
        child: SizedBox(
          height: 0.4.h,
          child: LinearProgressIndicator(
            minHeight: 2,
            color: Colors.white,
            value: index == page ? _animation.value : 0,
            semanticsLabel: 'null',
          ),
        ),
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

  Widget _pagerInformation() {
    var page = 0;
    try { page = _pageController.page?.round() ?? 0; } catch(_) {}
    var list = [
      CarouselModel(
          'sale | inv22',
          'descontos especiais em pe??as selecionadas da cole??nao Natureza',
          'compre',
          primaryColor: Colors.white,
          secondaryColor: Colors.black
      ),
      CarouselModel(
          'ascari',
          '| Vintage e Contepor??neo |\n\nCole????o em parceria com Helio Ascari',
          'conhe??a',
          primaryColor: Colors.white,
          secondaryColor: Colors.black
      ),
      CarouselModel(
        'shoes',
        'est??tica | ??tica | funcionalidade',
        'compre',
      ),
      CarouselModel(
        'tons terrosos',
        'Novas cores | cole????o natureza',
        'compre',
      )
    ];

    return Padding(
      padding: EdgeInsets.only(bottom: 20.h),
      child: Align(
        alignment: AlignmentDirectional.bottomCenter,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              list[page].title,
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w900,
                fontSize: 6.sp,
                color: list[page].primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h,),
            Text(
              list[page].description,
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w500,
                fontSize: 3.sp,
                color: list[page].primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 2.h,),
            AppOutlinedButton(
              onPress: () {},
              title: list[page].button,
              primaryColor: list[page].primaryColor ?? Colors.black,
              secondaryColor: list[page].secondaryColor ?? Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
