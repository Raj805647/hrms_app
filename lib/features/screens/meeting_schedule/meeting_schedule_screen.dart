// lib/features/meeting/screens/schedule_meeting_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widget/custom_button.dart';
import '../metting/metting_provider.dart';

class ScheduleMeetingScreen extends StatefulWidget {
  const ScheduleMeetingScreen({super.key});

  @override
  State<ScheduleMeetingScreen> createState() => _ScheduleMeetingScreenState();
}

class _ScheduleMeetingScreenState extends State<ScheduleMeetingScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  DateTime _selectedDate = DateTime.now();
  TimeOfDay _startTime = const TimeOfDay(hour: 10, minute: 0);
  TimeOfDay _endTime = const TimeOfDay(hour: 11, minute: 0);
  String _selectedRecurring = "none";
  String _selectedColor = "blue";
  List<Map<String, String>> _participants = [];
  String _participantEmail = "";
  bool _requirePassword = false;
  String _password = "";

  final List<String> _recurringOptions = ["none", "daily", "weekly", "monthly"];
  final List<String> _colorOptions = ["blue", "green", "orange", "purple", "red"];

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final provider = Provider.of<MeetingProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Schedule Meeting"),
        backgroundColor: themeManager.surface,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Meeting Title
              _buildTextField(
                controller: _titleController,
                label: "Meeting Title",
                icon: Icons.title,
                validator: (v) => v?.isEmpty ?? true ? "Title is required" : null,
                themeManager: themeManager,
              ),
              const SizedBox(height: 16),

              // Description
              _buildTextField(
                controller: _descriptionController,
                label: "Description (Optional)",
                icon: Icons.description,
                maxLines: 3,
                themeManager: themeManager,
              ),
              const SizedBox(height: 16),

              // Date Picker
              _buildDatePicker(themeManager),
              const SizedBox(height: 16),

              // Time Picker Row
              Row(
                children: [
                  Expanded(child: _buildTimePicker("Start Time", _startTime, (time) {
                    setState(() => _startTime = time);
                  }, themeManager)),
                  const SizedBox(width: 12),
                  Expanded(child: _buildTimePicker("End Time", _endTime, (time) {
                    setState(() => _endTime = time);
                  }, themeManager)),
                ],
              ),
              const SizedBox(height: 16),

              // Recurring
              _buildDropdown(
                label: "Repeat",
                value: _selectedRecurring,
                items: _recurringOptions,
                onChanged: (v) => setState(() => _selectedRecurring = v!),
                themeManager: themeManager,
              ),
              const SizedBox(height: 16),

              // Color
              _buildColorPicker(themeManager),
              const SizedBox(height: 16),

              // Password Protection
              _buildPasswordProtection(themeManager),
              if (_requirePassword) ...[
                const SizedBox(height: 16),
                _buildTextField(
                  controller: TextEditingController(text: _password),
                  label: "Meeting Password",
                  icon: Icons.lock,
                  onChanged: (v) => _password = v,
                  themeManager: themeManager,
                ),
              ],
              const SizedBox(height: 16),

              // Participants
              _buildParticipantsSection(themeManager),
              const SizedBox(height: 30),

              // Action Buttons
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(vertical: 14),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: AppButton(
                      title: "Schedule Meeting",
                      onPressed: () => _scheduleMeeting(context, provider),
                      isLoading: provider.isLoaded,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    int maxLines = 1,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    required ThemeManager themeManager,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: themeManager.primary),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: themeManager.primary),
        ),
      ),
      style: TextStyle(color: themeManager.text),
    );
  }

  Widget _buildDatePicker(ThemeManager themeManager) {
    return InkWell(
      onTap: () async {
        final date = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime.now(),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(primary: themeManager.primary),
              ),
              child: child!,
            );
          },
        );
        if (date != null) setState(() => _selectedDate = date);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: themeManager.textSecondary.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(Icons.calendar_today, color: themeManager.primary),
            const SizedBox(width: 12),
            Text(
              "${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}",
              style: TextStyle(color: themeManager.text),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimePicker(String label, TimeOfDay time, Function(TimeOfDay) onChanged, ThemeManager themeManager) {
    return InkWell(
      onTap: () async {
        final newTime = await showTimePicker(
          context: context,
          initialTime: time,
          builder: (context, child) {
            return Theme(
              data: Theme.of(context).copyWith(
                colorScheme: ColorScheme.light(primary: themeManager.primary),
              ),
              child: child!,
            );
          },
        );
        if (newTime != null) onChanged(newTime);
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          border: Border.all(color: themeManager.textSecondary.withOpacity(0.3)),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 12, color: themeManager.textSecondary)),
            const SizedBox(height: 4),
            Text(
              time.format(context),
              style: TextStyle(color: themeManager.text),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown({
    required String label,
    required String value,
    required List<String> items,
    required Function(String?) onChanged,
    required ThemeManager themeManager,
  }) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
      ),
      items: items.map((item) {
        return DropdownMenuItem(
          value: item,
          child: Text(item.toUpperCase()),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }

  Widget _buildColorPicker(ThemeManager themeManager) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Meeting Color", style: TextStyle(color: themeManager.textSecondary)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 12,
          children: _colorOptions.map((color) {
            final isSelected = _selectedColor == color;
            return GestureDetector(
              onTap: () => setState(() => _selectedColor = color),
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: _getColorOption(color),
                  shape: BoxShape.circle,
                  border: isSelected
                      ? Border.all(color: themeManager.primary, width: 3)
                      : null,
                ),
                child: isSelected
                    ? const Icon(Icons.check, color: Colors.white, size: 20)
                    : null,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildPasswordProtection(ThemeManager themeManager) {
    return Row(
      children: [
        Checkbox(
          value: _requirePassword,
          onChanged: (v) => setState(() => _requirePassword = v ?? false),
          activeColor: themeManager.primary,
        ),
        Text("Require meeting password", style: TextStyle(color: themeManager.text)),
      ],
    );
  }

  Widget _buildParticipantsSection(ThemeManager themeManager) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Participants", style: TextStyle(color: themeManager.textSecondary)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: TextField(
                onChanged: (v) => _participantEmail = v,
                decoration: InputDecoration(
                  hintText: "Email address",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {
                if (_participantEmail.isNotEmpty) {
                  setState(() {
                    _participants.add({"email": _participantEmail});
                    _participantEmail = "";
                  });
                }
              },
              icon: Icon(Icons.add_circle, color: themeManager.primary),
            ),
          ],
        ),
        if (_participants.isNotEmpty) ...[
          const SizedBox(height: 12),
          ..._participants.map((participant) {
            return Chip(
              label: Text(participant['email']!),
              onDeleted: () {
                setState(() {
                  _participants.remove(participant);
                });
              },
            );
          }),
        ],
      ],
    );
  }

  void _scheduleMeeting(BuildContext context, MeetingProvider provider) {
    if (_formKey.currentState!.validate()) {
      final duration = "${_endTime.hour - _startTime.hour}h ${_endTime.minute - _startTime.minute}m";

      provider.scheduleMeeting({
        "title": _titleController.text,
        "description": _descriptionController.text,
        "date": _selectedDate,
        "startTime": _startTime.format(context),
        "endTime": _endTime.format(context),
        "duration": duration,
        "host": "John Doe",
        "hostId": "1",
        "password": _requirePassword ? _password : "",
        "participants": _participants,
        "recurring": _selectedRecurring,
        "color": _selectedColor,
      });

      Navigator.pop(context);
    }
  }

  Color _getColorOption(String color) {
    switch(color) {
      case "blue": return Colors.blue;
      case "green": return Colors.green;
      case "orange": return Colors.orange;
      case "purple": return Colors.purple;
      case "red": return Colors.red;
      default: return Colors.blue;
    }
  }
}