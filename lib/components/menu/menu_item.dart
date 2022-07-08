import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:osklen/components/measure_size.dart';
import 'package:sizer/sizer.dart';

import '../../app/modules/home/model/menu_model.dart';

class AppMenuItem extends StatefulWidget {
  final MenuModel model;
  AppMenuItem({Key? key, required this.model}) : super(key: key);

  @override
  State<AppMenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<AppMenuItem> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool _hasAnimation = false;
  Size _textSize = Size.zero;


  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() { });
      });
  }

  @override
  void dispose() {
    _controller.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      onHover: (value) {
        _hasAnimation = value;
        if (value) {
          _controller.forward();
        } else {
          _controller.reset();
        }
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          MeasureSize(
            onChange: (size) {
              setState(() { _textSize = size; });
            },
            child: Text(
              widget.model.title,
              style: GoogleFonts.lato(
                fontWeight: widget.model.fontWeight,
                fontSize: 3.sp,
                color: widget.model.color,
              ),
            ),
          ),
          SizedBox(height: 0.5.h,),
          _hasAnimation ? SizedBox(
            width: _textSize.width,
            child: LinearProgressIndicator(
              minHeight: 1,
              color: widget.model.color,
              backgroundColor: Colors.transparent,
              value: _animation.value,
              semanticsLabel: 'null',
            ),
          ) : const SizedBox(height: 1,),
        ],
      ),
    );
  }
}
