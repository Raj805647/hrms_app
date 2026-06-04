// lib/features/meeting/screens/meeting_room_screen.dart

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../metting/metting_provider.dart';

class MeetingRoomScreen extends StatefulWidget {
  const MeetingRoomScreen({super.key});

  @override
  State<MeetingRoomScreen> createState() => _MeetingRoomScreenState();
}

class _MeetingRoomScreenState extends State<MeetingRoomScreen> {
  bool _isMuted = false;
  bool _isVideoOn = true;
  bool _isScreenSharing = false;
  bool _isChatOpen = false;
  final List<Map<String, String>> _chatMessages = [];
  final TextEditingController _chatController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);
    final provider = Provider.of<MeetingProvider>(context);
    final meeting = provider.currentMeeting;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[900]!, Colors.black],
          ),
        ),
        child: Column(
          children: [
            // Main Video Area
            Expanded(
              child: Stack(
                children: [
                  // Main video
                  Container(
                    color: Colors.grey[800],
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.videocam_off,
                            size: 80,
                            color: Colors.grey[600],
                          ),
                          const SizedBox(height: 16),
                          Text(
                            meeting?['title'] ?? "Meeting",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Participant videos (simulated)
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Row(
                      children: [
                        _buildParticipantVideo("JD", "John Doe", themeManager),
                        const SizedBox(width: 8),
                        _buildParticipantVideo("SC", "Sarah Chen", themeManager),
                        const SizedBox(width: 8),
                        _buildParticipantVideo("MJ", "Mike Johnson", themeManager),
                      ],
                    ),
                  ),

                  // Meeting info
                  Positioned(
                    bottom: 20,
                    left: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        meeting?['meetingId'] ?? "meet-123",
                        style: const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                  ),

                  // Duration
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        "00:15:32",
                        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Chat Panel (if open)
            if (_isChatOpen)
              Container(
                height: 300,
                color: themeManager.surface,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        reverse: true,
                        padding: const EdgeInsets.all(12),
                        itemCount: _chatMessages.length,
                        itemBuilder: (context, index) {
                          final message = _chatMessages[_chatMessages.length - 1 - index];
                          return _buildChatMessage(message, themeManager);
                        },
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border(top: BorderSide(color: themeManager.textSecondary.withOpacity(0.1))),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _chatController,
                              decoration: InputDecoration(
                                hintText: "Type a message...",
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(24),
                                ),
                                contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                              ),
                              onSubmitted: (text) {
                                if (text.isNotEmpty) {
                                  setState(() {
                                    _chatMessages.add({
                                      "message": text,
                                      "sender": "Me",
                                      "time": _getCurrentTime(),
                                    });
                                  });
                                  _chatController.clear();
                                }
                              },
                            ),
                          ),
                          const SizedBox(width: 8),
                          IconButton(
                            onPressed: () {
                              if (_chatController.text.isNotEmpty) {
                                setState(() {
                                  _chatMessages.add({
                                    "message": _chatController.text,
                                    "sender": "Me",
                                    "time": _getCurrentTime(),
                                  });
                                  _chatController.clear();
                                });
                              }
                            },
                            icon: Icon(Icons.send, color: themeManager.primary),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

            // Control Bar
            Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 10,
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildControlButton(
                    icon: _isMuted ? Icons.mic_off : Icons.mic,
                    label: _isMuted ? "Unmute" : "Mute",
                    onTap: () => setState(() => _isMuted = !_isMuted),
                    isActive: !_isMuted,
                    themeManager: themeManager,
                  ),
                  _buildControlButton(
                    icon: _isVideoOn ? Icons.videocam : Icons.videocam_off,
                    label: _isVideoOn ? "Stop Video" : "Start Video",
                    onTap: () => setState(() => _isVideoOn = !_isVideoOn),
                    isActive: _isVideoOn,
                    themeManager: themeManager,
                  ),
                  _buildControlButton(
                    icon: Icons.present_to_all,
                    label: _isScreenSharing ? "Stop Share" : "Share Screen",
                    onTap: () => setState(() => _isScreenSharing = !_isScreenSharing),
                    isActive: _isScreenSharing,
                    themeManager: themeManager,
                  ),
                  _buildControlButton(
                    icon: Icons.chat,
                    label: "Chat",
                    onTap: () => setState(() => _isChatOpen = !_isChatOpen),
                    isActive: _isChatOpen,
                    themeManager: themeManager,
                  ),
                  _buildControlButton(
                    icon: Icons.people,
                    label: "Participants",
                    onTap: () => _showParticipants(context, meeting, themeManager),
                    isActive: false,
                    themeManager: themeManager,
                  ),
                  _buildControlButton(
                    icon: Icons.call_end,
                    label: "Leave",
                    onTap: () {
                      provider.endMeeting();
                      Navigator.pop(context);
                    },
                    isActive: false,
                    isEndCall: true,
                    themeManager: themeManager,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildParticipantVideo(String initial, String name, ThemeManager themeManager) {
    return Container(
      width: 100,
      height: 70,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: themeManager.primary, width: 1),
      ),
      child: Stack(
        children: [
          Center(
            child: CircleAvatar(
              radius: 20,
              backgroundColor: themeManager.primary.withOpacity(0.3),
              child: Text(initial, style: const TextStyle(color: Colors.white)),
            ),
          ),
          Positioned(
            bottom: 4,
            left: 4,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.6),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                name,
                style: const TextStyle(color: Colors.white, fontSize: 8),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildControlButton({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isActive,
    required ThemeManager themeManager,
    bool isEndCall = false,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isEndCall
                  ? Colors.red
                  : isActive
                  ? themeManager.primary
                  : Colors.grey[700],
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(color: Colors.white70, fontSize: 10),
        ),
      ],
    );
  }

  Widget _buildChatMessage(Map<String, String> message, ThemeManager themeManager) {
    final isMe = message['sender'] == "Me";
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: isMe ? themeManager.primary.withOpacity(0.2) : themeManager.surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message['sender']!,
              style: TextStyle(
                color: isMe ? themeManager.primary : themeManager.text,
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 4),
            Text(message['message']!, style: TextStyle(color: themeManager.text)),
            const SizedBox(height: 4),
            Text(
              message['time']!,
              style: TextStyle(color: themeManager.textSecondary, fontSize: 10),
            ),
          ],
        ),
      ),
    );
  }

  void _showParticipants(BuildContext context, Map<String, dynamic>? meeting, ThemeManager themeManager) {
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
              const Text(
                "Participants",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 16),
              ...(meeting?['participants'] as List).map((participant) {
                return ListTile(
                  leading: CircleAvatar(
                    child: Text(participant['name'][0]),
                  ),
                  title: Text(participant['name']),
                  subtitle: Text(participant['status']),
                  trailing: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      shape: BoxShape.circle,
                    ),
                  ),
                );
              }).toList(),
            ],
          ),
        );
      },
    );
  }

  String _getCurrentTime() {
    final now = DateTime.now();
    return "${now.hour}:${now.minute.toString().padLeft(2, '0')}";
  }
}