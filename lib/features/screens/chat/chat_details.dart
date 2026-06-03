import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'chat_provider.dart';

class ChatDetailScreen
    extends StatelessWidget {
  const ChatDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {

    return Consumer<ChatProvider>(
      builder: (_, provider, __) {

        return Scaffold(

          appBar: AppBar(
            title: const Text(
              "John Doe",
            ),
            actions: [

              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.call,
                ),
              ),

              IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.videocam,
                ),
              ),
            ],
          ),

          body: Column(
            children: [

              Expanded(
                child: _buildMessages(
                  provider,
                ),
              ),

              if (provider.isTyping)
                _buildTypingIndicator(),

              _buildMessageInput(
                provider,
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMessages(
      ChatProvider provider,
      ) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount:
      provider.messages.length,
      itemBuilder: (_, index) {

        final message =
        provider.messages[index];

        final isMe =
        message["isMe"];

        return Align(
          alignment: isMe
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            margin:
            const EdgeInsets.only(
              bottom: 12,
            ),
            padding:
            const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: isMe
                  ? Colors.blue
                  : Colors.white38,
              borderRadius:
              BorderRadius.circular(
                16,
              ),
            ),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.end,
              children: [

                Text(
                  message["message"],
                ),

                Row(
                  mainAxisSize:
                  MainAxisSize.min,
                  children: [

                    Text(
                      message["time"],
                    ),

                    if (isMe)
                      Icon(
                        message["seen"]
                            ? Icons.done_all
                            : Icons.done,
                        size: 16,
                      ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildTypingIndicator() {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Row(
        children: const [

          CircleAvatar(
            radius: 10,
          ),

          SizedBox(width: 8),

          Text(
            "Typing...",
          ),
        ],
      ),
    );
  }
  Widget _buildMessageInput(
      ChatProvider provider,
      ) {
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [

            IconButton(
              onPressed: () {
                /// File Picker
              },
              icon: const Icon(
                Icons.attach_file,
              ),
            ),

            IconButton(
              onPressed: () {
                /// Image Picker
              },
              icon: const Icon(
                Icons.image,
              ),
            ),

            Expanded(
              child: TextField(
                controller:
                provider.messageController,
                onChanged: (value) {
                  provider.updateTyping(
                    value.isNotEmpty,
                  );
                },
                decoration:
                const InputDecoration(
                  hintText:
                  "Type a message",
                ),
              ),
            ),

            IconButton(
              onPressed:
              provider.sendMessage,
              icon: const Icon(
                Icons.send,
              ),
            ),
          ],
        ),
      ),
    );
  }
}