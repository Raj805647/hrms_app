import 'package:flutter/material.dart';
import 'package:hrms_app/routes/route_names.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widget/help_widget.dart';
import 'metting_provider.dart';

class MeetingScreen extends StatefulWidget {
  const MeetingScreen({super.key});

  @override
  State<MeetingScreen> createState() => _MeetingScreenState();
}

class _MeetingScreenState extends State<MeetingScreen> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  CalendarFormat _calendarFormat = CalendarFormat.month;
  int _selectedTab = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MeetingProvider>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Consumer<MeetingProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: buildProfileAppBar(isLeading: true, context: context, title: 'Meetings'),
          floatingActionButton: _buildFloatingButton(context, themeManager, provider),
          body: Column(
            children: [
              _buildCalendar(themeManager, provider),
              _buildTabs(themeManager),
              Expanded(
                child: _selectedTab == 0
                    ? _buildUpcomingMeetings(provider, themeManager)
                    : _buildPastMeetings(provider, themeManager),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFloatingButton(BuildContext context, ThemeManager themeManager, MeetingProvider provider) {
    return FloatingActionButton.extended(
      onPressed: () => provider.navigateTo(context, RouteNames.meetingScheduleScreen),
      backgroundColor: themeManager.primary,
      icon: const Icon(Icons.add, color: Colors.white),
      label: const Text(
        "Schedule Meeting",
        style: TextStyle(color: Colors.white),
      ),
    );
  }

  Widget _buildCalendar(ThemeManager themeManager, MeetingProvider provider) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: themeManager.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: TableCalendar(
        firstDay: DateTime.now(),
        lastDay: DateTime.now().add(const Duration(days: 365)),
        focusedDay: _focusedDay,
        calendarFormat: _calendarFormat,
        onFormatChanged: (format) {
          setState(() => _calendarFormat = format);
        },
        onDaySelected: (selected, focused) {
          setState(() {
            _selectedDay = selected;
            _focusedDay = focused;
          });
        },
        calendarStyle: CalendarStyle(
          todayDecoration: BoxDecoration(
            color: themeManager.primary.withOpacity(0.2),
            shape: BoxShape.circle,
          ),
          selectedDecoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [themeManager.primary, themeManager.secondary],
            ),
            shape: BoxShape.circle,
          ),
          markerDecoration: BoxDecoration(
            color: themeManager.primary,
            shape: BoxShape.circle,
          ),
        ),
        headerStyle: HeaderStyle(
          formatButtonVisible: true,
          titleCentered: true,
          formatButtonDecoration: BoxDecoration(
            color: themeManager.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        eventLoader: (day) {
          final count = provider.getMeetingCountForDate(day);
          return List.generate(count, (index) => null);
        },
      ),
    );
  }

  Widget _buildTabs(ThemeManager themeManager) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: themeManager.surface,
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          _buildTabItem("Upcoming", 0, themeManager),
          _buildTabItem("Past", 1, themeManager),
        ],
      ),
    );
  }

  Widget _buildTabItem(String title, int index, ThemeManager themeManager) {
    final isSelected = _selectedTab == index;
    return Expanded(
      child: GestureDetector(
        onTap: () => setState(() => _selectedTab = index),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            gradient: isSelected
                ? LinearGradient(
                    colors: [themeManager.primary, themeManager.secondary],
                  )
                : null,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: isSelected ? Colors.white : themeManager.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildUpcomingMeetings(
    MeetingProvider provider,
    ThemeManager themeManager,
  ) {
    final meetings = provider.getFilteredMeetings();

    if (meetings.isEmpty) {
      return _buildEmptyState(themeManager);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: meetings.length,
      itemBuilder: (context, index) {
        final meeting = meetings[index];
        return _buildMeetingCard(meeting, provider, themeManager);
      },
    );
  }

  Widget _buildMeetingCard(
    Map<String, dynamic> meeting,
    MeetingProvider provider,
    ThemeManager themeManager,
  ) {
    final date = meeting['date'] as DateTime;
    final isToday =
        date.year == DateTime.now().year &&
        date.month == DateTime.now().month &&
        date.day == DateTime.now().day;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: themeManager.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            _showMeetingOptions(context, meeting, provider, themeManager);
          },
          borderRadius: BorderRadius.circular(20),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 4,
                      height: 40,
                      decoration: BoxDecoration(
                        color: _getColor(meeting['color'], themeManager),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            meeting['title'],
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: themeManager.text,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            "${_formatDate(date)} • ${meeting['startTime']} - ${meeting['endTime']}",
                            style: TextStyle(
                              fontSize: 12,
                              color: themeManager.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    if (isToday)
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: const Text(
                          "Today",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    _buildInfoChip(
                      Icons.person_outline,
                      meeting['host'],
                      themeManager,
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      Icons.access_time,
                      meeting['duration'],
                      themeManager,
                    ),
                    const SizedBox(width: 8),
                    _buildInfoChip(
                      Icons.group_add_rounded,
                      "${meeting['participants'].length} participants",
                      themeManager,
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: () {
                          provider.joinMeeting(meeting);
                        provider.navigateTo(context, RouteNames.meetingRoomScreen);
                        },
                        icon: const Icon(Icons.video_call, size: 18),
                        label: const Text("Join"),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    IconButton(
                      onPressed: () {
                        _shareMeetingLink(meeting['meetingLink']);
                      },
                      icon: Icon(Icons.share, color: themeManager.primary),
                    ),
                    IconButton(
                      onPressed: () {
                        _copyMeetingLink(meeting['meetingLink']);
                      },
                      icon: Icon(Icons.link, color: themeManager.primary),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    IconData icon,
    String label,
    ThemeManager themeManager,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: themeManager.primary.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: themeManager.primary),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(fontSize: 11, color: themeManager.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildPastMeetings(
    MeetingProvider provider,
    ThemeManager themeManager,
  ) {
    if (provider.pastMeetings.isEmpty) {
      return _buildEmptyState(themeManager);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: provider.pastMeetings.length,
      itemBuilder: (context, index) {
        final meeting = provider.pastMeetings[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: themeManager.surface,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            children: [
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: themeManager.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(Icons.video_library, color: themeManager.primary),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      meeting['title'],
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: themeManager.text,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "${_formatDate(meeting['date'])} • ${meeting['startTime']}",
                      style: TextStyle(
                        fontSize: 12,
                        color: themeManager.textSecondary,
                      ),
                    ),
                    Text(
                      "${meeting['duration']} • ${meeting['participants']} participants",
                      style: TextStyle(
                        fontSize: 11,
                        color: themeManager.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
              if (meeting['recording'] != null)
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.play_circle, color: themeManager.primary),
                ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(ThemeManager themeManager) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.videocam_off, size: 80, color: themeManager.textSecondary),
          const SizedBox(height: 16),
          Text(
            "No meetings scheduled",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: themeManager.text,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Schedule a new meeting to get started",
            style: TextStyle(color: themeManager.textSecondary),
          ),
        ],
      ),
    );
  }

  void _showMeetingOptions(
    BuildContext context,
    Map<String, dynamic> meeting,
    MeetingProvider provider,
    ThemeManager themeManager,
  ) {
    showModalBottomSheet(
      context: context,
      backgroundColor: themeManager.surface,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: Icon(Icons.edit, color: themeManager.primary),
                title: const Text("Edit Meeting"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.person_add, color: themeManager.primary),
                title: const Text("Add Participants"),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.delete, color: Colors.red),
                title: const Text("Cancel Meeting"),
                onTap: () {
                  provider.cancelMeeting(meeting['id']);
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  String _formatDate(DateTime date) {
    return "${date.day} ${_getMonthName(date.month)} ${date.year}";
  }

  String _getMonthName(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec",
    ];
    return months[month - 1];
  }

  Color _getColor(String color, ThemeManager themeManager) {
    switch (color) {
      case "blue":
        return Colors.blue;
      case "green":
        return Colors.green;
      case "orange":
        return Colors.orange;
      default:
        return themeManager.primary;
    }
  }

  void _shareMeetingLink(String link) {
    // Implement share functionality
  }

  void _copyMeetingLink(String link) {
    // Implement copy to clipboard
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text("Meeting link copied")));
  }
}
