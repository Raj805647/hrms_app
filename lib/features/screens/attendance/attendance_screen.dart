import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widget/custom_button.dart';
import '../../../widget/help_widget.dart';
import 'attendance_provider.dart';

class AttendanceScreen extends StatelessWidget {
  const AttendanceScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<AttendanceProvider>(
      builder: (_, provider, __) {

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "Attendance",
            ),
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                _buildAttendanceCard(
                  context,
                  provider,
                ),

                spaceHeight(20),

                _buildLocationCard(
                  context,
                  provider,
                ),

                spaceHeight(20),

                _buildSummaryCard(
                  context,
                ),

                spaceHeight(20),

                _buildHistorySection(
                  context,
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildAttendanceCard(
      BuildContext context,
      AttendanceProvider provider,
      ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [

          const Icon(
            Icons.access_time_filled,
            size: 50,
          ),

          spaceHeight(15),

          Text(
            DateFormat(
              "hh:mm:ss a",
            ).format(
              provider.currentTime,
            ),
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),

          spaceHeight(15),

          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 14,
              vertical: 8,
            ),
            decoration: BoxDecoration(
              color: provider.isCheckedIn
                  ? Colors.green.shade100
                  : Colors.red.shade100,
              borderRadius:
              BorderRadius.circular(50),
            ),
            child: Text(
              provider.isCheckedIn
                  ? "Checked In"
                  : "Checked Out",
            ),
          ),

          spaceHeight(20),

          Row(
            children: [

              Expanded(
                child: AppButton(
                  title: "Punch In",
                  icon: Icons.login_rounded,
                  onPressed: () {
                    provider.punchIn(
                      context,
                    );
                  },
                ),
              ),

              spaceWidth(12),

              Expanded(
                child: OutlinedButton.icon(
                  onPressed: () {
                    provider.punchOut(
                      context,
                    );
                  },
                  icon: const Icon(
                    Icons.logout_rounded,
                  ),
                  label: const Text(
                    "Punch Out",
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLocationCard(
      BuildContext context,
      AttendanceProvider provider,
      ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [

          ListTile(
            leading: const Icon(
              Icons.location_on,
            ),
            title: const Text(
              "Current Location",
            ),
            subtitle: Text(
              provider.location,
            ),
          ),

          ListTile(
            leading: const Icon(
              Icons.timer,
            ),
            title: const Text(
              "Working Hours",
            ),
            subtitle: Text(
              provider.workingHours,
            ),
          ),

          ListTile(
            leading: const Icon(
              Icons.warning_amber,
            ),
            title: const Text(
              "Late Arrival",
            ),
            subtitle: Text(
              "${provider.lateMinutes} Minutes",
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSummaryCard(
      BuildContext context,
      ) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceAround,
        children: const [

          Column(
            children: [
              Text("22"),
              Text("Present"),
            ],
          ),

          Column(
            children: [
              Text("01"),
              Text("Absent"),
            ],
          ),

          Column(
            children: [
              Text("02"),
              Text("Leave"),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildHistorySection(
      BuildContext context,
      ) {
    return Column(
      crossAxisAlignment:
      CrossAxisAlignment.start,
      children: [

        const Text(
          "Attendance History",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        spaceHeight(15),

        ListView.builder(
          shrinkWrap: true,
          physics:
          const NeverScrollableScrollPhysics(),
          itemCount: 10,
          itemBuilder: (_, index) {
            return Card(
              child: ListTile(
                leading: const Icon(
                  Icons.calendar_today,
                ),
                title: Text(
                  "01 Jul 2025",
                ),
                subtitle: Text(
                  "09:00 AM - 06:00 PM",
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}