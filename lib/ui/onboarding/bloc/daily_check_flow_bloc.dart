
import 'dart:async';

import 'package:admin_dashboard/app/helper/daily_check_flow_screen_list.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/common/color_model.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/customcard_model.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/yesorno_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';


class DailyCheckFlowBloc{

  int currentScreen = 0;
  final int totalScreens = DailyCheckFlowScreenList.dailyCheckFlowScreens;

  // this Stream controller for progress bar (using the current page value)
  StreamController<int> dailyCheckFlowProgressStream =
  StreamController<int>.broadcast();
  Stream<int> get dailyCheckFlowProgressListSc => dailyCheckFlowProgressStream.stream;

  final TextEditingController enterReasonController = TextEditingController();

  // views States
  final dcQ1SelectedIndex = BehaviorSubject<int>.seeded(-1);
  final dcQ2SelectedIndex = BehaviorSubject<int>.seeded(-1);
  final dcQ3Puffs = BehaviorSubject<int>.seeded(01);
  final dcQ4SelectedIndex = BehaviorSubject<int>.seeded(-1);
  final dcQ6SelectedIndex = BehaviorSubject<int>.seeded(-1);
  final dcQ7SelectedIndex = BehaviorSubject<int>.seeded(-1);
  final dcQ8SelectedIndex = BehaviorSubject<int>.seeded(-1);

  updateUi() {
    dailyCheckFlowProgressStream.sink.add(currentScreen);
  }

  DailyCheckFlowBloc() {
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
      dailyCheckFlowProgressStream.sink.add(currentScreen);
    }
  }

  // this function is go to preview view
  void previousScreen() async {
    if (currentScreen > 0) {
      currentScreen--;
      dailyCheckFlowProgressStream.sink.add(currentScreen);
    }
  }



  void setQ1index(int index){
    dcQ1SelectedIndex.add(index);
  }

  void setQ2index(int index){
    dcQ2SelectedIndex.add(index);
  }

  void setQ3index(int index){
    dcQ3Puffs.add(index);
  }

  void setQ4index(int index){
    dcQ4SelectedIndex.add(index);
  }

  void setQ6index(int index){
    dcQ6SelectedIndex.add(index);
  }

  void setQ7index(int index){
    dcQ7SelectedIndex.add(index);
  }

  void setQ8index(int index){
    dcQ8SelectedIndex.add(index);
  }

  bool buttonDisabled(int currentPage) {
    if (currentPage == DailyCheckFlowScreenList.q1){
      if(dcQ1SelectedIndex.value == -1){
        return true;
      }
    }
    if (currentPage == DailyCheckFlowScreenList.q2){
      if(dcQ2SelectedIndex.value == -1){
        return true;
      }
    }
    if (currentPage == DailyCheckFlowScreenList.q4){
      if(dcQ4SelectedIndex.value == -1){
        return true;
      }
    }
    if (currentPage == DailyCheckFlowScreenList.q5){
      if(enterReasonController.text.toString().isEmpty){
        return true;
      }
    }
    if (currentPage == DailyCheckFlowScreenList.q6){
      if(dcQ6SelectedIndex.value == -1){
        return true;
      }
    }
    if (currentPage == DailyCheckFlowScreenList.q7){
      if(dcQ7SelectedIndex.value == -1){
        return true;
      }
    }
    if (currentPage == DailyCheckFlowScreenList.q8){
      if(dcQ8SelectedIndex.value == -1){
        return true;
      }
    }
    return false;
  }

  String answers(int currentPage) {
    switch (currentPage) {
      case DailyCheckFlowScreenList.q1:
        return "Your answer is  ${DcQ1List[dcQ1SelectedIndex.value].title}  is it correct ?";
      case DailyCheckFlowScreenList.q2:
        return "Your answer is  ${yesOrNoList[dcQ2SelectedIndex.value].title}  is it correct ?";
      case DailyCheckFlowScreenList.q3:
        return "Your answer is  ${dcQ3Puffs.value}  is it correct ?";
      case DailyCheckFlowScreenList.q4:
        return "Your answer is  ${yesOrNoList[dcQ4SelectedIndex.value].title}  is it correct ?";
      case DailyCheckFlowScreenList.q5:
        return "Your answer is  ${enterReasonController.text.toString()}  is it correct ?";
      case DailyCheckFlowScreenList.q6:
        return "Your answer is  ${yesOrNoList[dcQ6SelectedIndex.value].title}  is it correct ?";
      case DailyCheckFlowScreenList.q7:
        return "Your answer is  ${dcQ7List[dcQ7SelectedIndex.value].colorName}  is it correct ?";
      case DailyCheckFlowScreenList.q8:
        return "Your answer is  ${yesOrNoList[dcQ8SelectedIndex.value].title}  is it correct ?";
      default:
        return "";
    }
  }
}