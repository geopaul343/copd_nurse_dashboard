class AuthCardModel {
  String? tittle;
  bool isSelected = false;

  AuthCardModel({this.tittle});
}

var languagesList = [
  AuthCardModel(tittle: "🇬🇧  English"),
  AuthCardModel(tittle: "🇸🇦  Arabic"),
  AuthCardModel(tittle: "🇩🇪  German"),
  AuthCardModel(tittle: "🇮🇳  Hindi"),
  AuthCardModel(tittle: "🇯🇵  Japanese"),
  AuthCardModel(tittle: "🇰🇷  Korean"),
];

var diagnosedList = [
  AuthCardModel(tittle: "COPD"),
  AuthCardModel(tittle: "Asthma"),
];
