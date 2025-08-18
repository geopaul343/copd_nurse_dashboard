import 'package:flutter/cupertino.dart';
import 'package:gap/gap.dart';
import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:admin_dashboard/app/style_guide/typography.dart';
import 'package:admin_dashboard/app/helper/text_to_audio_helper.dart';
import 'package:admin_dashboard/app/string_constants.dart';
import '../../bloc/common/text_to_speech_bloc.dart';
import '../../bloc/onBoardingBloc.dart';

class DobView extends StatefulWidget {
  final OnboardingBloc bloc;
  final TextToSpeechBloc textToSpeechBloc;
  const DobView({super.key, required this.bloc,required this.textToSpeechBloc});

  @override
  State<DobView> createState() => _DobViewState();
}

class _DobViewState extends State<DobView> with AutoSpeechMixin {
  @override
  void initState() {
    super.initState();

    subscribeToSpeechStream(
      stream: widget.textToSpeechBloc.isAutoSpeechQuestion,
      onSpeak: () => widget.textToSpeechBloc.textToSpeech("${StringConstants.yourDateOfBirth} ${widget.bloc.enterNameController.text}?"),
      onStop: () => widget.textToSpeechBloc.stopSpeech(),
      // reset: widget.bloc.setAutoSpeach,
    );
  }

  @override
  Widget build(BuildContext context) {
    int selectedYear = widget.bloc.selectedDate?.year ?? 2000;
    int selectedMonth = widget.bloc.selectedDate?.month ?? 1;
    int selectedDay = widget.bloc.selectedDate?.day ?? 1;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("${StringConstants.yourDateOfBirth} ${widget.bloc.enterNameController.text}?", style: h24),
        Gap(16),
        Container(
          height: (MediaQuery.of(context).size.height) * 0.2808,
          width: double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: ColorName.grey1,
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                height:
                    (MediaQuery.of(context).size.height) *
                    0.0521, // Matches itemExtent of the picker
                width: MediaQuery.of(context).size.width - 83,
                margin: EdgeInsets.symmetric(horizontal: 17),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: ColorName.grey2, // Add transparency
                  border: Border.all(
                    color: ColorName.buttonBackground,
                    width: 1,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 5,
                  vertical: (MediaQuery.of(context).size.height) * 0.0284,
                ),
                child: Row(
                  children: [
                    // Year Picker
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent:
                            (MediaQuery.of(context).size.height) * 0.0521,
                        selectionOverlay: null,
                        onSelectedItemChanged: (int index) {
                          selectedYear = 1900 + index;
                          _updateDate(selectedYear, selectedMonth, selectedDay);
                        },
                        scrollController: FixedExtentScrollController(
                          initialItem: selectedYear - 1900,
                        ),
                        children: List<Widget>.generate(
                          DateTime.now().year - 1900 + 1,
                          (int index) {
                            final year = 1900 + index;
                            final isSelected = year == selectedYear;
                            return Center(
                              child: Text(
                                '${1900 + index}',
                                style:
                                    isSelected
                                        ? selectionDobOnboarding
                                        : disSelectionDobOnboarding,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    // Month Picker
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent:
                            (MediaQuery.of(context).size.height) * 0.0521,
                        selectionOverlay: null,
                        onSelectedItemChanged: (int index) {
                          selectedMonth = index + 1;
                          _updateDate(selectedYear, selectedMonth, selectedDay);
                        },
                        scrollController: FixedExtentScrollController(
                          initialItem: selectedMonth - 1,
                        ),
                        children: List<Widget>.generate(12, (int index) {
                          final month = index + 1;
                          final isSelected = month == selectedMonth;
                          return Center(
                            child: Text(
                              '${index + 1}',
                              style:
                                  isSelected
                                      ? selectionDobOnboarding
                                      : disSelectionDobOnboarding,
                            ),
                          );
                        }),
                      ),
                    ),
                    // Day Picker
                    Expanded(
                      child: CupertinoPicker(
                        itemExtent:
                            (MediaQuery.of(context).size.height) * 0.0521,
                        selectionOverlay: null,
                        onSelectedItemChanged: (int index) {
                          selectedDay = index + 1;
                          _updateDate(selectedYear, selectedMonth, selectedDay);
                        },
                        scrollController: FixedExtentScrollController(
                          initialItem: selectedDay - 1,
                        ),
                        children: List<Widget>.generate(
                          _daysInMonth(selectedYear, selectedMonth),
                          (int index) {
                            final day = index + 1;
                            final isSelected = day == selectedDay;
                            return Center(
                              child: Text(
                                '${index + 1}',
                                style:
                                    isSelected
                                        ? selectionDobOnboarding
                                        : disSelectionDobOnboarding,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _updateDate(int year, int month, int day) {
    // Ensure the day doesn't exceed the days in the selected month/year
    int maxDays = _daysInMonth(year, month);
    if (day > maxDays) day = maxDays;

    setState(() {
      widget.bloc.selectedDate = DateTime(year, month, day);
      widget.bloc.updateUi();
    });
  }

  int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }
}
