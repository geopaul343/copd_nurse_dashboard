import 'dart:async';

import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/auth_card_model.dart';


class SelectLanguageBloc {
  StreamController<List<AuthCardModel>> languagesListStream =
      StreamController<List<AuthCardModel>>.broadcast();
  Stream<List<AuthCardModel>> get languagesListSc => languagesListStream.stream;

  // languages list
  List<AuthCardModel> languagesList = [];

  // this function for fetch all languages
  getLanguagesList(List<AuthCardModel> languages) async {
    languagesList = await List.from(languages);
    languagesListStream.sink.add(languagesList); // Add this to confirm sink
  }

  // this function for search languages
  void searchLanguages(String query) {
    final filtered =
        languagesList
            .where(
              (lang) =>
                  lang.tittle?.toLowerCase().contains(query.toLowerCase()) ??
                  false,
            )
            .toList();
    languagesListStream.sink.add(filtered);
  }

  void dispose() {
    languagesListStream.close();
  }
}
