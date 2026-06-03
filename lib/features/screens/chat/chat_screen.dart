import 'package:flutter/material.dart';
import 'package:hrms_app/routes/route_names.dart';
import '../../../widget/help_widget.dart';
import 'chat_provider.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ChatProvider>(
      builder: (_, provider, __) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text("Chats"),
          ),

          floatingActionButton:
          FloatingActionButton(
            onPressed: () {},
            child: const Icon(
              Icons.group_add,
            ),
          ),

          body: Column(
            children: [

              _buildSearchBar(),

              // _buildOnlineUsers(),

              Expanded(
                child: _buildChatList(
                  context,
                  provider,
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        decoration: InputDecoration(
          hintText: "Search chats...",
          prefixIcon: const Icon(
            Icons.search,
          ),
          border: OutlineInputBorder(
            borderRadius:
            BorderRadius.circular(16),
          ),
        ),
      ),
    );
  }

  Widget _buildOnlineUsers() {
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding:
        const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        itemCount: 10,
        itemBuilder: (_, index) {
          return Padding(
            padding:
            const EdgeInsets.only(
              right: 12,
            ),
            child: Column(
              children: [

                Stack(
                  children: [

                    const CircleAvatar(
                      radius: 28,
                      child: Text("J"),
                    ),

                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 14,
                        width: 14,
                        decoration:
                        BoxDecoration(
                          color: Colors.green,
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          shape:
                          BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),

                spaceHeight(6),

                const Text(
                  "John",
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildChatList(BuildContext context,
      ChatProvider provider,) {
    return ListView.builder(
      itemCount: provider.chats.length,
      itemBuilder: (_, index) {
        final chat =
        provider.chats[index];

        return ListTile(

          onTap: ()=> provider.navigateTo(context, RouteNames.chatDetailsScreen),

          leading: CircleAvatar(
            child: Text(
              chat["name"][0],
            ),
          ),

          title: Text(
            chat["name"],
          ),

          subtitle: Text(
            chat["message"],
          ),

          trailing: Column(
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [

              Text(chat["time"]),

              if (chat["unread"] > 0)
                Container(
                  padding:
                  const EdgeInsets.all(6),
                  decoration:
                  const BoxDecoration(
                    color: Colors.green,
                    shape:
                    BoxShape.circle,
                  ),
                  child: Text(
                    chat["unread"]
                        .toString(),
                    style:
                    const TextStyle(
                      color:
                      Colors.white,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}


