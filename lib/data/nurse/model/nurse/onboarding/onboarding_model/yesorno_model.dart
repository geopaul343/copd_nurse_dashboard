// Updated model with proper camelCase and corrected title.
class YesOrNoCardModel {
  String? title;
  bool isSelected = false;

  YesOrNoCardModel({this.title});
}

var yesOrNoList = [
  YesOrNoCardModel(title: "YES"),
  YesOrNoCardModel(title: "NO"),
];
