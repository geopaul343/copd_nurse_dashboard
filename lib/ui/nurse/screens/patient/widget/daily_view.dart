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
    return Card(
      elevation: 3,
      shadowColor: ColorName.shadowForAuthenticationContainer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: ColorName.grey3, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- Header ---
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  data.userName ?? "Unknown User",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                if (data.createdAt != null)
                  Text(
                    DateConverter.isoStringToLocalDateOnly(data.createdAt!),
                    style: TextStyle(
                      fontSize: 13,
                      color: ColorName.grey600,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
            const Divider(
              color: ColorName.grey3,
              thickness: .5,
            ),
    
            // --- Body Data ---
            _buildInfoRow("Breathing", "${data.data?.breathing ?? "N/A"}"),
            _buildInfoRow(
              "Did Short Walk",
              data.data?.didShortWalk == true ? "✅ Yes" : "❌ No",
            ),
            _buildInfoRow(
              "Has Inhaler Stock",
              data.data?.hasInhalerStock == true
                  ? "✅ Available"
                  : "❌ Not Available",
            ),
            _buildInfoRow(
              "Phlegm Change",
              "${data.data?.phlegmChange ?? "N/A"}",
            ),
            _buildInfoRow(
              "Phlegm Color",
              "${data.data?.phlegmColor ?? "N/A"}",
            ),
            _buildInfoRow(
              "Reliever Puffs",
              "${data.data?.relieverPuffs ?? "N/A"}",
            ),
            _buildInfoRow("SpO₂", "${data.data?.spo2 ?? "N/A"}"),
            _buildInfoRow(
              "Regular Inhaler",
              data.data?.tookRegularInhaler == true ? "✅ Taken" : "❌ Missed",
            ),
            _buildInfoRow(
              "Oxygen Prescribed",
              data.data?.usedOxygenAsPrescribed == true
                  ? "✅ Used"
                  : "❌ Not Used",
            ),
    
            // --- Audio Section ---
            if (data.data?.lungSoundRecordings != null &&
                data.data!.lungSoundRecordings!.isNotEmpty) ...[
              const SizedBox(height: 10),
              Text(
                "Lung Sound Recordings",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: ColorName.textBlue1,
                ),
              ),
           Gap(6),
              Wrap(
                spacing: 6,
                children:
                    data.data!.lungSoundRecordings!
                        .map(
                          (audio) => AudioWidget(
                            url: audio.fileUri ?? "",
                            controller: audioController,
                          ),
                        )
                        .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(value, style: const TextStyle(fontSize: 14)),
          ),
        ],
      ),
    );
  }

  // Widget buildDailyContent(UserDailyDatum data) {
  //   return Padding(
  //     padding: const EdgeInsets.fromLTRB(10, 0, 10, 5),
  //     child: Column(
  //       mainAxisAlignment: MainAxisAlignment.start,
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Text("UserName: ${data.userName ?? "N/A"}"),
  //         Text("Breathing: ${data.data?.breathing ?? "N/A"}"),
  //         Text(
  //           "DidShortWalk: ${data.data?.didShortWalk == true ? "Available" : "Not Available"}",
  //         ),
  //         Text(
  //           "HasInhalerStock: ${data.data?.hasInhalerStock == true ? "Available" : "Not Available"}",
  //         ),
  //         Text("PhlegmChange: ${data.data?.phlegmChange ?? "N/A"}"),
  //         Text("PhlegmColor: ${data.data?.phlegmColor ?? "N/A"}"),
  //         Text("RelieverPuffs: ${data.data?.relieverPuffs ?? "N/A"}"),
  //         Text("spo2: ${data.data?.spo2 ?? "N/A"}"),
  //         Text(
  //           "TookRegularInhaler: ${data.data?.tookRegularInhaler == true ? "Available" : "Not Available"}",
  //         ),
  //         Text(
  //           "UsedOxygenAsPrescribed: ${data.data?.usedOxygenAsPrescribed == true ? "Available" : "Not Available"}",
  //         ),
  //         data.createdAt != null
  //             ? Text(
  //               "Date: ${DateConverter.isoStringToLocalDateOnly(data.createdAt!)}",
  //             )
  //             : SizedBox(),
  //         if (data.data?.lungSoundRecordings != null ||
  //             data.data?.lungSoundRecordings?.isNotEmpty == true) ...[
  //           Text("Audios "),
  //           Row(
  //             children:
  //                 data.data!.lungSoundRecordings!
  //                     .map(
  //                       (audio) => Padding(
  //                         padding: const EdgeInsets.only(right: 5),
  //                         child: AudioWidget(
  //                           url: audio.fileUri ?? "",
  //                           controller: audioController,
  //                         ),
  //                       ),
  //                     )
  //                     .toList(),
  //           ),
  //         ],
  //       ],
  //     ),
  //   );
  // }

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

            return Padding(
              padding: const EdgeInsets.only(bottom: 5.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: ColorName.grey3, width: 1.2),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: ExpansionTileTheme(
                    data: ExpansionTileThemeData(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      collapsedShape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      backgroundColor: ColorName.primary.withValues(alpha: 0.1),
                      collapsedBackgroundColor: ColorName.lightBackgroundColor,
                      iconColor: ColorName.primary,
                      collapsedIconColor: ColorName.grey500,
                      tilePadding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      childrenPadding: const EdgeInsets.all(8),
                    ),
                    child: ExpansionTile(
                      title: Text(title),
                      subtitle: const Text('Tap to view Patient details'),
                      children: dayEntries.map(buildDailyContent).toList(),
                    ),
                  ),
                ),
              ),
            );
          },
        );
  }
}
