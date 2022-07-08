import 'package:flutter/material.dart';

class CarouselModel {
  String title;
  String description;
  String button;
  Color? primaryColor;
  Color? secondaryColor;

  CarouselModel(this.title, this.description, this.button, {
        this.primaryColor, this.secondaryColor
  });
}