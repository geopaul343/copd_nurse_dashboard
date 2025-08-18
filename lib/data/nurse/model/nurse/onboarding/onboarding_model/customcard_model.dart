class CustomSelectioncardModel {
  String? title;
  bool isSelected = false;

  CustomSelectioncardModel({this.title});
}

//view Q2  list

var viewQTwoList = [
  CustomSelectioncardModel(title: "Mild"),
  CustomSelectioncardModel(title: "Moderate"),
  CustomSelectioncardModel(title: "Severe"),
  CustomSelectioncardModel(title: "Not Sure"),
];

//view Q5  list

var viewQFiveList = [
  CustomSelectioncardModel(title: "I know the brand name"),
  CustomSelectioncardModel(title: "I am not sure"),
];

//view Q7  list

var viewQSevenList = [
  CustomSelectioncardModel(title: "Blue inhaler"),
  CustomSelectioncardModel(title: "Purple inhaler"),
];

//view Q9  list

var viewQNineList = [
  CustomSelectioncardModel(title: "Steroid tablets"),

  CustomSelectioncardModel(title: "Antibiotics"),
  CustomSelectioncardModel(title: "Both"),
];

//view Q13 list

var viewQThirteenList = [
  CustomSelectioncardModel(title: "Ex or Current smoker "),

  CustomSelectioncardModel(title: "Never smocked"),
];

//view Q14  list

var viewQFourteenList = [
  CustomSelectioncardModel(title: "01-05"),
  CustomSelectioncardModel(title: "05-10"),
  CustomSelectioncardModel(title: "10-20 "),
  CustomSelectioncardModel(title: "20+"),
];

//view Q16  list

var viewQSixteenList = [
  CustomSelectioncardModel(title: " Heart disease "),
  CustomSelectioncardModel(title: " High blood pressure "),
  CustomSelectioncardModel(title: " Diabetes "),
  CustomSelectioncardModel(title: " Anxiety "),
  CustomSelectioncardModel(title: " Depression "),
  CustomSelectioncardModel(title: " Other "),
];

//view Q20  list

var viewQTwentyList = [
  CustomSelectioncardModel(title: "YES"),
  CustomSelectioncardModel(title: "NO"),
  CustomSelectioncardModel(title: "Unsure "),
];

//view Q22  list

var viewQTwentytwoList = [
  CustomSelectioncardModel(title: "Frequent inhaler technique checks"),
  CustomSelectioncardModel(title: "Extra fluid intake"),
  CustomSelectioncardModel(title: "Special exercises "),
];


/// Daily Check Views list

 var DcQ1List = [
  CustomSelectioncardModel(title: "😊 No breathlessness"),
  CustomSelectioncardModel(title: "😕 Mild breathlessness"),
  CustomSelectioncardModel(title: "😰 Moderate breathlessness"),
  CustomSelectioncardModel(title: "😵 Severe breathlessness"),
  CustomSelectioncardModel(title: "😫 Very severe breathlessness"),
];

 // weekly and monthly check views


var WmcQ2List = [
  CustomSelectioncardModel(title: "I only get breathless with strenuous exercise"),
  CustomSelectioncardModel(title: "I get short of breath when hurrying on level ground or walking up a slight hill"),
  CustomSelectioncardModel(title: "On level ground, I walk slower than people of my age because of breathlessness, or I have to stop for breath when walking at my own pace on the level	"),
  CustomSelectioncardModel(title: "I stop for breath after walking about 100 yards or after a few minutes on level ground"),
  CustomSelectioncardModel(title: "I am too breathless to leave the house or I am breathless when dressing/undressing"),
];

class CustomSubSelectioncardModel {
  String? questions;
  List<CustomSelectioncardModel>? answers;

  CustomSubSelectioncardModel({this.questions, this.answers});
}

var WmcQ4List = [
  CustomSubSelectioncardModel(questions: "1. Little interest or pleasure in doing things",
      answers: [CustomSelectioncardModel(title:"Not at all"),CustomSelectioncardModel(title:"Several days"),CustomSelectioncardModel(title:"More than half the days"),CustomSelectioncardModel(title:"Nearly every day")]),
  CustomSubSelectioncardModel(questions: "2. Feeling down, depressed or hopeless",
answers: [CustomSelectioncardModel(title:"Not at all"),CustomSelectioncardModel(title:"Several days"),CustomSelectioncardModel(title:"More than half the days"),CustomSelectioncardModel(title:"Nearly every day")]),
];
