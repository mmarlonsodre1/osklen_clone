import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppOutlinedButton extends StatefulWidget {
  final String title;
  final Function onPress;
  Color primaryColor;
  Color secondaryColor;

  AppOutlinedButton({
    Key? key,
    required this.title,
    required this.onPress,
    this.primaryColor = Colors.black,
    this.secondaryColor = Colors.white
  }) : super(key: key);

  @override
  State<AppOutlinedButton> createState() => _AppOutlinedButtonState();
}

class _AppOutlinedButtonState extends State<AppOutlinedButton> {
  bool _isHover = false;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => widget.onPress.call(),
        onHover: (value) => setState(() { _isHover = value; }),
        child: Container(
          decoration: BoxDecoration(
             color: !_isHover ? Colors.transparent : widget.primaryColor,
              border: Border.all(
                color: widget.primaryColor,
                width: 1,
              )),
          child: Padding(
            padding: EdgeInsets.only(
                left: 3.w, right: 3.w,
                top: 1.h, bottom: 1.h
            ),
            child: Text(
              widget.title,
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w800,
                fontSize: 3.sp,
                color: _isHover ? widget.secondaryColor : widget.primaryColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
