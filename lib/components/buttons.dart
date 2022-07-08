import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class AppOutlinedButton extends StatelessWidget {
  final String title;
  final Function onPress;
  final Color color;
  const AppOutlinedButton({Key? key, required this.onPress, required this.title, required this.color}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => onPress.call(),
        child: Container(
          decoration: BoxDecoration(
              border: Border.all(
                color: color,
                width: 1,
              )),
          child: Padding(
            padding: EdgeInsets.only(
              left: 1.5.w, right: 1.5.w,
              top: 1.h, bottom: 1.h
            ),
            child: Text(
              title,
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w800,
                fontSize: 3.sp,
                color: color,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
