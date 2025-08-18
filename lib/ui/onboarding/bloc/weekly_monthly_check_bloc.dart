import 'dart:async';

import 'package:admin_dashboard/app/helper/weekly_monthly_check_screens_list.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/customcard_model.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/yesorno_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';


class WeeklyAndMonthlyCheckFlowBloc {

  int currentScreen = 0;
  final int totalScreens = WeeklyMonthlyCheckScreensList
      .weeklyAndMonthlyCheckFlowScreens;

  // this Stream controller for progress bar (using the current page value)
  StreamController<int> weeklyAndMonthlyCheckFlowProgressStream =
  StreamController<int>.broadcast();

  Stream<int> get weeklyAndMonthlyCheckFlowProgressListSc =>
      weeklyAndMonthlyCheckFlowProgressStream.stream;

  final TextEditingController enterReasonController = TextEditingController();

  // views States
  final wmcQ1SelectedIndex = BehaviorSubject<int>.seeded(-1);
  final wmcQ2SelectedIndex = BehaviorSubject<int>.seeded(-1);
  final wmcQ3SelectedIndex = BehaviorSubject<int>.seeded(-1);
  final wmcQ4SelectedIndices = BehaviorSubject<List<int>>.seeded(
    List.filled(WmcQ4List.length, -1), // Initialize with -1 for each question
  );
  final wmcQ5SelectedIndex = BehaviorSubject<int>.seeded(-1);

  updateUi() {
    weeklyAndMonthlyCheckFlowProgressStream.sink.add(currentScreen);
  }

  WeeklyAndMonthlyCheckFlowBloc() {
    enterReasonController.addListener(() {
      updateUi();
    });
  }

  double getProgressValue() {
    return (currentScreen + 1) / totalScreens;
  }

  // this function is go to next view
  void nextScreen() async {
    if (currentScreen < totalScreens - 1) {
      currentScreen++;
      weeklyAndMonthlyCheckFlowProgressStream.sink.add(currentScreen);
    }
  }

  // this function is go to preview view
  void previousScreen() async {
    if (currentScreen > 0) {
      currentScreen--;
      weeklyAndMonthlyCheckFlowProgressStream.sink.add(currentScreen);
    }
  }


  void setQ1index(int index) {
    wmcQ1SelectedIndex.add(index);
  }

  void setQ2index(int index) {
    wmcQ2SelectedIndex.add(index);
  }

  void setQ3index(int index) {
    wmcQ3SelectedIndex.add(index);
  }

  void setQ4index(int questionIndex, int answerIndex) {
    final currentIndices = wmcQ4SelectedIndices.value;
    currentIndices[questionIndex] =
        answerIndex; // Update the index for the specific question
    wmcQ4SelectedIndices.add(currentIndices); // Notify listeners
  }

  List<Map<String, String?>> getSelectedAnswersWithQuestions() {
    final selectedIndices = wmcQ4SelectedIndices.value;
    List<Map<String, String?>> result = [];

    for (int i = 0; i < WmcQ4List.length; i++) {
      String? question = WmcQ4List[i].questions;
      String? selectedAnswer;

      // Check if the selected index for this question is valid
      if (i < selectedIndices.length && selectedIndices[i] >= 0 &&
          selectedIndices[i] < (WmcQ4List[i].answers?.length ?? 0)) {
        selectedAnswer = WmcQ4List[i].answers![selectedIndices[i]].title;
      } else {
        selectedAnswer = null; // No answer selected for this question
      }

      result.add({
        'question': question,
        'answer': selectedAnswer,
      });
    }

    return result;
  }

  String printSelectedAnswersWithQuestions() {
    final selectedAnswersWithQuestions = getSelectedAnswersWithQuestions();
    var answers =[];
    for (var item in selectedAnswersWithQuestions) {
      answers.add(item['answer']);
    }
    return answers.join(',').toString();
  }

    void setQ5index(int index) {
      wmcQ5SelectedIndex.add(index);
    }


  bool hasExactlyTwoAnswersSelected() {
      final selectedIndices = wmcQ4SelectedIndices.value;

      // Check if the list has exactly 2 elements (one for each question)
      if (selectedIndices.length != 2) {
        return true; // Return false if the list doesn't have 2 elements
      }

      // Check if both questions have a valid answer selected
      for (int i = 0; i < selectedIndices.length; i++) {
        // Ensure the index is valid (not -1 and within the answers list bounds)
        if (selectedIndices[i] < 0 || selectedIndices[i] >= (WmcQ4List[i].answers?.length ?? 0)) {
          return true; // Return false if any question has no valid answer
        }
      }

      return false; // Return true if both questions have valid answers
  }

    bool buttonDisabled(int currentPage) {
      if (currentPage == WeeklyMonthlyCheckScreensList.q1) {
        if (wmcQ1SelectedIndex.value == -1) {
          return true;
        }
      }
      if (currentPage == WeeklyMonthlyCheckScreensList.q2) {
        if (wmcQ2SelectedIndex.value == -1) {
          return true;
        }
      }

      if (currentPage == WeeklyMonthlyCheckScreensList.q4) {
            return hasExactlyTwoAnswersSelected();
      }
      return false;
    }

    String answers(int currentPage) {
      switch (currentPage) {
        case WeeklyMonthlyCheckScreensList.q1:
          return "Your answer is  ${yesOrNoList[wmcQ1SelectedIndex.value]
              .title}  is it correct ?";
        case WeeklyMonthlyCheckScreensList.q2:
          return "Your answer is  ${WmcQ2List[wmcQ2SelectedIndex.value]
              .title}  is it correct ?";
        case WeeklyMonthlyCheckScreensList.q3:
          return "Your answer is  ${yesOrNoList[wmcQ3SelectedIndex.value]
              .title}  is it correct ?";
      case WeeklyMonthlyCheckScreensList.q4:
        return "Your answer is  ${printSelectedAnswersWithQuestions()} is it correct ?";
        default:
          return "";
      }
    }
  }
