import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:osklen/app/modules/home/model/carousel_model.dart';
import 'package:osklen/components/buttons.dart';
import 'package:sizer/sizer.dart';
import 'package:video_player/video_player.dart';

class SecondCarousel extends StatefulWidget {
  const SecondCarousel({Key? key}) : super(key: key);

  @override
  State<SecondCarousel> createState() => _SecondCarouselState();
}

class _SecondCarouselState extends State<SecondCarousel> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
    _resetAnimation();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _resetAnimation() {
    _controller = AnimationController(
        duration: const Duration(seconds: 6), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      })..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _updatePage(hasReset: false);
          _controller.reset();
          _controller.forward();
        }
      });
    _controller.forward();
  }

  void _updatePage({bool isUp = true, bool hasReset = true}) {
    var page = 0;
    try {
      page = _pageController.page?.round() ?? 0;
    } catch(_) {}
    if (isUp) {
      if (page == 2) {
        page = 0;
      } else {
        page += 1;
      }
    } else {
      if (page == 0) {
        page = 2;
      } else {
        page -= 1;
      }
    }
    _pageController.animateToPage(
        page,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeIn
    );
    if (hasReset) {
      _resetAnimation();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100.w,
      height: 70.h,
      color: Colors.white,
      child: Stack(
        children: [
          _pager(),
          Positioned(
              top: 1,
              bottom: 1,
              left: 5.w,
              child: IconButton(
                onPressed: () => _updatePage(isUp: false),
                icon: Icon(
                  Icons.chevron_left,
                  size: 5.h,
                  color: Colors.black,
                ),
              )
          ),
          Positioned(
              top: 1,
              bottom: 1,
              right: 5.w,
              child: IconButton(
                onPressed: () => _updatePage(),
                icon: Icon(
                  Icons.chevron_right,
                  size: 5.h,
                  color: Colors.black,
                ),
              )
          )
        ],
      ),
    );
  }


  List<String> nameList = ['creeper', 'soho', 'Trkk'];
  Widget _pager() {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        _pagerItem('assets/images/img_second_carousel1.webp', 'creeper'),
        _pagerItem('assets/images/img_second_carousel2.webp', 'soho'),
        _pagerItem('assets/images/img_second_carousel3.webp', 'Trkk'),
      ],
    );
  }

  Widget _pagerItem(String image, String title) {
    return Stack(
      children: [
        Positioned(
          left: 1,
          right: 1,
          child: Image.asset(
            image,
            height: 40.h,
          ),
        ),
        Positioned(
          top: 33.h,
          left: 1,
          right: 1,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w900,
                  fontSize: 6.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 2.h,),
              AppOutlinedButton(
                  title: 'conheça',
                  onPress: () {}
              )
            ],
          ),
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
          'descontos especiais em peças selecionadas da coleçnao Natureza',
          'compre',
          primaryColor: Colors.white,
          secondaryColor: Colors.black
      ),
      CarouselModel(
          'ascari',
          '| Vintage e Conteporâneo |\n\nColeção em parceria com Helio Ascari',
          'conheça',
          primaryColor: Colors.white,
          secondaryColor: Colors.black
      ),
      CarouselModel(
        'shoes',
        'estética | ética | funcionalidade',
        'compre',
      ),
      CarouselModel(
        'tons terrosos',
        'Novas cores | coleção natureza',
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
