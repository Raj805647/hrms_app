import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widget/help_widget.dart';
import 'chat_provider.dart';

class ChatDetailScreen extends StatelessWidget {
  const ChatDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Consumer<ChatProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: buildProfileAppBar(
            isLeading: true,
            context: context,
            title:  "Chat",
            action: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.call, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.videocam, color: Colors.white),
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.more_vert, color: Colors.white),
              ),            ],
          ),
          body: Column(
            children: [
              Expanded(
                child: _buildMessagesList(context, provider, themeManager),
              ),
              if (provider.isTyping) _buildTypingIndicator(themeManager),
              _buildMessageInput(context, provider, themeManager),
            ],
          ),
        );
      },
    );
  }


  // Messages List
  Widget _buildMessagesList(BuildContext context, ChatProvider provider, ThemeManager themeManager) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      reverse: true,
      controller: ScrollController(),
      itemCount: provider.messages.length,
      itemBuilder: (context, index) {
        final message = provider.messages[provider.messages.length - 1 - index];
        return _buildMessageBubble(context, message, themeManager);
      },
    );
  }

  // Message Bubble
  Widget _buildMessageBubble(BuildContext context, Map<String, dynamic> message, ThemeManager themeManager) {
    final isMe = message["isMe"];

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        constraints: BoxConstraints(
          maxWidth: MediaQuery.of(context).size.width * 0.75,
        ),
        child: Stack(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                gradient: isMe
                    ? LinearGradient(
                  colors: [themeManager.primary, themeManager.secondary],
                )
                    : null,
                color: isMe ? null : themeManager.surface,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    message["message"],
                    style: TextStyle(
                      color: isMe ? Colors.white : themeManager.text,
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        message["time"],
                        style: TextStyle(
                          fontSize: 10,
                          color: isMe ? Colors.white70 : themeManager.textSecondary,
                        ),
                      ),
                      if (isMe) ...[
                        const SizedBox(width: 4),
                        Icon(
                          message["seen"] == true ? Icons.done_all :
                          message["delivered"] == true ? Icons.done_all : Icons.done,
                          size: 14,
                          color: message["seen"] == true
                              ? Colors.white
                              : message["delivered"] == true
                              ? Colors.white70
                              : Colors.white70,
                        ),
                      ],
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Typing Indicator
  Widget _buildTypingIndicator(ThemeManager themeManager) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: themeManager.primary.withOpacity(0.1),
            child: Icon(Icons.person, size: 12, color: themeManager.primary),
          ),
          const SizedBox(width: 8),
          Text(
            "Typing...",
            style: TextStyle(
              color: themeManager.textSecondary,
              fontSize: 12,
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(width: 4),
          _buildTypingAnimation(),
        ],
      ),
    );
  }

  // Typing Animation
  Widget _buildTypingAnimation() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(3, (index) {
        return AnimatedOpacity(
          duration: Duration(milliseconds: 500),
          opacity: 1.0,
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 1),
            height: 6,
            width: 6,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
        );
      }),
    );
  }

  // Message Input
  Widget _buildMessageInput(BuildContext context, ChatProvider provider, ThemeManager themeManager) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: themeManager.surface,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          children: [
            // Attach Button
            Container(
              decoration: BoxDecoration(
                color: themeManager.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  _showAttachmentOptions(context, themeManager);
                },
                icon: Icon(Icons.attach_file, color: themeManager.primary),
              ),
            ),
            const SizedBox(width: 8),

            // Image Button
            Container(
              decoration: BoxDecoration(
                color: themeManager.primary.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () {
                  _showImageOptions(context);
                },
                icon: Icon(Icons.image, color: themeManager.primary),
              ),
            ),
            const SizedBox(width: 8),

            // Text Field
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: themeManager.background,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  controller: provider.messageController,
                  onChanged: (value) {
                    provider.updateTyping(value.isNotEmpty);
                  },
                  decoration: InputDecoration(
                    hintText: "Type a message...",
                    hintStyle: TextStyle(color: themeManager.textSecondary),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  style: TextStyle(color: themeManager.text),
                ),
              ),
            ),

            // Send Button
            const SizedBox(width: 8),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [themeManager.primary, themeManager.secondary],
                ),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: () => provider.sendMessage(),
                icon: const Icon(Icons.send, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Attachment Options Bottom Sheet
  void _showAttachmentOptions(BuildContext context, ThemeManager themeManager) {
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
                "Attach File",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildAttachmentOption(Icons.insert_drive_file, "Document", themeManager),
                  _buildAttachmentOption(Icons.picture_as_pdf, "PDF", themeManager),
                  _buildAttachmentOption(Icons.audiotrack, "Audio", themeManager),
                  _buildAttachmentOption(Icons.video_file, "Video", themeManager),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
    );
  }

  // Attachment Option
  Widget _buildAttachmentOption(IconData icon, String label, ThemeManager themeManager) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: themeManager.primary.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: themeManager.primary, size: 28),
        ),
        const SizedBox(height: 8),
        Text(label, style: TextStyle(color: themeManager.textSecondary)),
      ],
    );
  }

  // Image Options
  void _showImageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text("Take a Photo"),
              ),
              const ListTile(
                leading: Icon(Icons.image),
                title: Text("Choose from Gallery"),
              ),
            ],
          ),
        );
      },
    );
  }
}