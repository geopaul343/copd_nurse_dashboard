import 'dart:ui';

class ColorsModel {
  Color? colorCode;
  String? colorName;
  bool isSelected = false;

  ColorsModel({this.colorName,this.colorCode});
}

//view Q2  list

var dcQ7List = [
  ColorsModel(colorCode:Color(0xff75FF2A), colorName: "Green"),
  ColorsModel(colorCode:Color(0xffFADD00), colorName: "Yellow"),
  ColorsModel(colorCode:Color(0xffFFFFFF), colorName: "White"),
  ColorsModel(colorCode:Color(0xffC8C8C8), colorName: "Other"),
];