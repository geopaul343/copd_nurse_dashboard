import 'dart:async';
import 'dart:io';
import 'package:admin_dashboard/app/helper/onboarding_screen_list.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/customcard_model.dart';
import 'package:admin_dashboard/data/nurse/model/nurse/onboarding/onboarding_model/yesorno_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class OnboardingBloc {
  int currentScreen = 0;
  final int totalScreens = OnboardingScreens.onboardingScreens;

  // this Stream controller for progress bar (using the current page value)
  StreamController<int> onBoardingProgressStream =
      StreamController<int>.broadcast();
  Stream<int> get onBoardingProgressListSc => onBoardingProgressStream.stream;

  final TextEditingController enterNameController = TextEditingController();
  final TextEditingController inhalerBrandControllerQ6 =
      TextEditingController();
  final TextEditingController otherConditionControllerQ17 =
      TextEditingController();

  final TextEditingController q21Controller = TextEditingController();
  File? q21File;
  String? q21FileSize;
  DateTime? selectedDate;
  int selectedCOPDIndexQ1 = -1;
  int selectedDiagnosedIndexQ2 = -1;
  int selectedIndexQ3 = -1;
  int selectedExperienceIndexQ4 = 1;
  int selectedInhalerTypeIndexQ5 = -1;
  int selectedInhalersIndexQ7 = -1;
  int selectedRescuePackIndexQ8 = -1;
  int selecteSteroidOrAntibioticsQ9 = -1;
  int selectedHealthCareInstructionIndexQ10 = -1;
  int selectedHospitalCareIndexQ11 = -1;
  int selectedExperienceIndexQ12 = 1;
  int selectedSmockingIndexQ13 = -1;
  int cigaretteCoutIndexQ14 = -1;
  int cigaretteHowLongIndexQ14A = -1;
  int selectedCigarettesIndexQ15 = -1;
  int selectedhealthConditionIndexQ16 = -1;
  int selectedHomeOxiygenTherapyIndexQ18 = -1;
  int oxygenIntakeIndexQ19 = 9;
  int selectedPrescribedHoursIndexQ20 = -1;
  int selectedClinicalTeamAdviceIndexQ22 = -1;

  final List<CustomSelectioncardModel> viewQSixteenListUi = viewQSixteenList;

  // // for text to speech
  // final isAutuSpeachQuestion = BehaviorSubject<bool>.seeded(false);
  // FlutterTts flutterTts = FlutterTts();
  // This function is is updating next button color
  updateUi() {
    onBoardingProgressStream.sink.add(currentScreen);
  }

  OnboardingBloc() {
    enterNameController.addListener(() {
      updateUi();
    });

    inhalerBrandControllerQ6.addListener(() {
      updateUi();
    });
    otherConditionControllerQ17.addListener(() {
      updateUi();
    });
    q21Controller.addListener(() {
      updateUi();
    });
  }

  // setAutoSpeach(bool isEnable) {
  //   isAutuSpeachQuestion.add(isEnable);
  // }

  // this function is calculate the progress value
  double getProgressValue() {
    return (currentScreen + 1) / totalScreens;
  }

  // this function is go to next view
  void nextScreen() async {
    if (currentScreen < totalScreens - 1) {
      currentScreen++;
      onBoardingProgressStream.sink.add(currentScreen);
    }
  }

  // this function is go to preview view
  void previousScreen() async {
    if (currentScreen > 0) {
      currentScreen--;
      onBoardingProgressStream.sink.add(currentScreen);
    }
  }

  String answers(int currentPage) {
    switch (currentPage) {
      case OnboardingScreens.name:
        return "Can you please confirm—your name is  ${enterNameController.text} ?";
      case OnboardingScreens.dob:
        return "Your Date of Birth is  ${selectedDate?.year ?? 2000}-${selectedDate?.month ?? 1}-${selectedDate?.day ?? 1} shall we proceed?";
      case OnboardingScreens.q1:
        return "Your answer is  ${yesOrNoList[selectedCOPDIndexQ1].title}  is it correct ?";
      case OnboardingScreens.q2:
        return "Your answer is  ${viewQTwoList[selectedDiagnosedIndexQ2].title}  shall we proceed?";
      case OnboardingScreens.q3:
        return "Your answer is  ${yesOrNoList[selectedIndexQ3].title}  is it correct ?";
      case OnboardingScreens.q4:
        return "Your answer is  $selectedExperienceIndexQ4  is it correct ?";
      case OnboardingScreens.q5:
        return "Your answer is  ${viewQFiveList[selectedInhalerTypeIndexQ5].title}  is it correct ?";
      case OnboardingScreens.q6:
        return "Your answer is  ${inhalerBrandControllerQ6.text}  is it correct ?";
      case OnboardingScreens.q7:
        return "Your answer is  ${viewQSevenList[selectedInhalersIndexQ7].title}  is it correct ?";
      case OnboardingScreens.q8:
        return "Your answer is  ${yesOrNoList[selectedRescuePackIndexQ8].title}  is it correct ?";

      case OnboardingScreens.q9:
        return "Your answer is  ${viewQNineList[selecteSteroidOrAntibioticsQ9].title}  is it correct ?";

      case OnboardingScreens.q10:
        return "Your answer is  ${yesOrNoList[selectedHealthCareInstructionIndexQ10].title}  is it correct ?";

      case OnboardingScreens.q11:
        return "Your answer is  ${yesOrNoList[selectedHospitalCareIndexQ11].title}  is it correct ?";

      case OnboardingScreens.q12:
        return "Your answer is  $selectedExperienceIndexQ12  is it correct ?";

      case OnboardingScreens.q13:
        return "Your answer is  ${viewQThirteenList[selectedSmockingIndexQ13].title}  is it correct ?";

      case OnboardingScreens.q14:
        return "Your answer is  ${viewQFourteenList[cigaretteCoutIndexQ14].title}  is it correct ?";

      case OnboardingScreens.q14A:
        return "Your answer is  ${viewQFourteenList[cigaretteHowLongIndexQ14A].title} is it correct ?";

      case OnboardingScreens.q15:
        return "Your answer is  ${yesOrNoList[selectedCigarettesIndexQ15].title} is it correct ?";

      case OnboardingScreens.q16:
        return "Your answer is  ${viewQSixteenList.where((e) => e.isSelected).map((e) => e.title).join(', ')} is it correct ? ";

      case OnboardingScreens.q17:
        return "Your answer is  ${otherConditionControllerQ17.text} is it correct ? ";

      case OnboardingScreens.q18:
        return "Your answer is  ${yesOrNoList[selectedHomeOxiygenTherapyIndexQ18].title} is it correct ?";
      case OnboardingScreens.q19:
        return "Your answer is  $oxygenIntakeIndexQ19  is it correct ?";

      case OnboardingScreens.q20:
        return "Your answer is  ${viewQTwentyList[selectedPrescribedHoursIndexQ20].title} is it correct ?";

      case OnboardingScreens.q21:
        return q21File == null
            ? "Your answer is  ${q21Controller.text}  is it correct ?"
            : "Is the file you selected correct?";

      case OnboardingScreens.q22:
        return "Your answer is  ${viewQTwentytwoList[selectedClinicalTeamAdviceIndexQ22].title}  is it correct ?";

      default:
        return " ";
    }
  }

  // Future textTospeech(String text) async {
  //   await flutterTts.speak(text);
  // }
  //
  // Future<void> stopSpeech() async {
  //   await flutterTts.stop();
  // }

  // this function is validate the next button for each view one by one
  bool buttonDisabled(int currentPage) {
    if (currentPage == OnboardingScreens.name) {
      if (enterNameController.text.isEmpty) {
        return true;
      }
    }

    if (currentPage == OnboardingScreens.dob) {
      if (selectedDate != null && selectedDate!.isAfter(DateTime.now()) ||
          selectedDate == DateTime.now()) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q1) {
      if (selectedCOPDIndexQ1 == -1) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q2) {
      if (selectedDiagnosedIndexQ2 == -1) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q3) {
      if (selectedIndexQ3 == -1) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q4) {
      if (selectedExperienceIndexQ4 == -1) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q5) {
      if (selectedInhalerTypeIndexQ5 == -1) {
        return true;
      }
    }

    if (currentPage == OnboardingScreens.q6) {
      if (inhalerBrandControllerQ6.text.isEmpty) {
        return true;
      }
    }

    if (currentPage == OnboardingScreens.q7) {
      if (selectedInhalersIndexQ7 == -1) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q8) {
      if (selectedRescuePackIndexQ8 == -1) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q9) {
      if (selecteSteroidOrAntibioticsQ9 == -1) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q10) {
      if (selectedHealthCareInstructionIndexQ10 == -1) {
        return true;
      }
    }

    if (currentPage == OnboardingScreens.q11) {
      if (selectedHospitalCareIndexQ11 == -1) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q12) {
      if (selectedExperienceIndexQ12 == -1) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q13) {
      if (selectedSmockingIndexQ13 == -1) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q14) {
      if (cigaretteCoutIndexQ14 == -1) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q14A) {
      if (cigaretteHowLongIndexQ14A == -1) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q15) {
      if (selectedCigarettesIndexQ15 == -1) {
        return true;
      }
    }

    if (currentPage == OnboardingScreens.q16) {
      if (!viewQSixteenListUi.any((item) => item.isSelected)) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q17) {
      if (otherConditionControllerQ17.text.isEmpty) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q18) {
      if (selectedHomeOxiygenTherapyIndexQ18 == -1) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q19) {
      if (oxygenIntakeIndexQ19 == -1) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q20) {
      if (selectedPrescribedHoursIndexQ20 == -1) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q21) {
      if (q21File == null && q21Controller.text.isEmpty) {
        return true;
      }
    }
    if (currentPage == OnboardingScreens.q22) {
      if (selectedClinicalTeamAdviceIndexQ22 == -1) {
        return true;
      }
    }

    return false;
  }

  void dispose() {
    enterNameController.dispose();
    inhalerBrandControllerQ6.dispose();
    otherConditionControllerQ17.dispose();
    q21Controller.dispose();
  }
}
