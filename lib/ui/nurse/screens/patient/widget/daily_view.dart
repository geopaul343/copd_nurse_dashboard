import 'package:admin_dashboard/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';

import '../../../../../app/helper/audio_helper.dart';
import '../../../../../app/helper/date_helper.dart';
import '../../../../../data/nurse/model/nurse/patient_checkup_data_model.dart';
import '../../../../widgets/custom_audio_player.dart';
import '../../../bloc/dashboard_bloc.dart';

class DailyViewWidget extends StatelessWidget {
  final List<UserDailyDatum>? userDailyData;
  final AudioPlayerController audioController;
  final DashboardBloc _bloc =
      DashboardBloc(); // Replace with your actual Bloc instance

  DailyViewWidget({
    Key? key,
    required this.userDailyData,
    required this.audioController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _dailyView(userDailyData);
  }

  Widget buildDailyContent(UserDailyDatum data) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("UserName: ${data.userName ?? "N/A"}"),
          Text("Breathing: ${data.data?.breathing ?? "N/A"}"),
          Text(
            "DidShortWalk: ${data.data?.didShortWalk == true ? "Available" : "Not Available"}",
          ),
          Text(
            "HasInhalerStock: ${data.data?.hasInhalerStock == true ? "Available" : "Not Available"}",
          ),
          Text("PhlegmChange: ${data.data?.phlegmChange ?? "N/A"}"),
          Text("PhlegmColor: ${data.data?.phlegmColor ?? "N/A"}"),
          Text("RelieverPuffs: ${data.data?.relieverPuffs ?? "N/A"}"),
          Text("spo2: ${data.data?.spo2 ?? "N/A"}"),
          Text(
            "TookRegularInhaler: ${data.data?.tookRegularInhaler == true ? "Available" : "Not Available"}",
          ),
          Text(
            "UsedOxygenAsPrescribed: ${data.data?.usedOxygenAsPrescribed == true ? "Available" : "Not Available"}",
          ),
          data.createdAt != null
              ? Text(
                "Date: ${DateConverter.isoStringToLocalDateOnly(data.createdAt!)}",
              )
              : SizedBox(),
          if (data.data?.lungSoundRecordings != null ||
              data.data?.lungSoundRecordings?.isNotEmpty == true) ...[
            Text("Audios "),
            Row(
              children:
                  data.data!.lungSoundRecordings!
                      .map(
                        (audio) => Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: AudioWidget(
                            url: audio.fileUri ?? "",
                            controller: audioController,
                          ),
                        ),
                      )
                      .toList(),
            ),
          ],
        ],
      ),
    );
  }

  Widget _dailyView(List<UserDailyDatum>? userDailyData) {
    // Group entries by day
    Map<String, List<UserDailyDatum>> entriesByDay = {};
    for (var entry in userDailyData ?? []) {
      DateTime createdAt = DateTime.parse(entry.createdAt.toString());
      // Format date as YYYY-MM-DD
      String dayKey = DateFormat('yyyy-MM-dd').format(createdAt);
      if (!entriesByDay.containsKey(dayKey)) {
        entriesByDay[dayKey] = [];
      }
      entriesByDay[dayKey]!.add(entry);
    }

    // Sort days in descending order (most recent first)
    var sortedDays = entriesByDay.keys.toList()..sort((a, b) => b.compareTo(a));

    return userDailyData == null || userDailyData.isEmpty
        ? const Center(child: Text("No Details Found!"))
        : ListView.builder(
          itemCount: sortedDays.length,
          itemBuilder: (context, index) {
            String dayKey = sortedDays[index];
            List<UserDailyDatum> dayEntries = entriesByDay[dayKey]!;

            // Format title as "Month Day, Year (N entries)"
            DateTime date = DateTime.parse(dayKey);
            String title =
                '${DateFormat('MMMM dd, yyyy').format(date)} (${dayEntries.length} entries)';

            return 
            
    //         Padding(
    //           padding: const EdgeInsets.only(bottom: 5),
    //           child: Container(decoration: BoxDecoration(
    //   color: ColorName.white, // Background outside ExpansionTile
    //   borderRadius: BorderRadius.circular(12),
    //   border: Border.all(
    //     color: ColorName.grey3, // border color
    //  //   width: 1.2, // border thickness
    //   ),
    //   boxShadow: [
    //     BoxShadow(
    //       color: ColorName.white.withValues(alpha: 0.5), // shadow color
    //      // blurRadius: 4,
    //     //  offset: Offset(0, 2),
    //     ),
    //   ],
    // ),
    //             child: ExpansionTile(
    //               backgroundColor: ColorName.primary.withValues(
    //                 alpha: 0.4,
    //               ), // Background color when expanded
    //               collapsedBackgroundColor:
    //                   ColorName.lightBackgroundColor, // soft blue highlight
    //               // textColor: Colors.blue, // Text color when expanded
    //               collapsedTextColor:
    //                   ColorName.black, // Text color when collapsed
    //               iconColor: ColorName.darkBackgroundColor.withValues(
    //                 alpha: 0.2,
    //               ), // Icon color when expanded
    //               collapsedIconColor: ColorName.grey500,
    //               title: Text(title),
    //               subtitle: const Text('Tap to view Patient details'),
                
    //               children:
    //                   dayEntries.map((entry) {
    //                     return Container(
    //                       color: ColorName.white, // soft blue highlight
                
    //                       child: buildDailyContent(entry),
    //                     );
    //                   }).toList(),
    //             ),
    //           ),
    //         );


           Padding(
             padding: const EdgeInsets.only(bottom:5.0),
             child: Container(
               decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(12),
                 border: Border.all(
                   color: ColorName.grey3,
                   width: 1.2,
                 ),
               ),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(12),
                 child: ExpansionTile(
                   backgroundColor: ColorName.primary.withValues(alpha: 0.1),
                   collapsedBackgroundColor: ColorName.lightBackgroundColor,
                   collapsedTextColor: ColorName.black,
                   iconColor: ColorName.darkBackgroundColor.withValues(alpha: 0.5),
                   collapsedIconColor: ColorName.grey500,
                   title: Text(title),
                   subtitle: const Text('Tap to view Patient details'),
                   children: dayEntries.map((entry) {
                     return Container(
                       color: ColorName.white,
                       child: buildDailyContent(entry),
                     );
                   }).toList(),
                 ),
               ),
             ),
           );



          },
        );
  }
}
