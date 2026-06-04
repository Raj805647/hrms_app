import 'package:flutter/material.dart';
import 'package:hrms_app/routes/route_names.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widget/help_widget.dart';
import 'chat_provider.dart';
import 'package:provider/provider.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Consumer<ChatProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: buildProfileAppBar(
            context: context,
            title: "Messages",
            action: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.person_add, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                  style: IconButton.styleFrom(
                    backgroundColor: Colors.white.withOpacity(0.2),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: _buildFloatingActionButton(context, themeManager),
          body: Column(
            children: [
              _buildSearchBar(context, provider, themeManager),
              _buildOnlineUsersSection(context, themeManager),
              Expanded(
                child: _buildChatList(context, provider, themeManager),
              ),
            ],
          ),
        );
      },
    );
  }

  // App Bar
  // Floating Action Button
  Widget _buildFloatingActionButton(BuildContext context, ThemeManager themeManager) {
    return FloatingActionButton(
      onPressed: () {},
      backgroundColor: themeManager.primary,
      child: const Icon(Icons.chat, color: Colors.white),
    );
  }

  // Search Bar
  Widget _buildSearchBar(BuildContext context, ChatProvider provider, ThemeManager themeManager) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container(
        decoration: BoxDecoration(
          color: themeManager.surface,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
            ),
          ],
        ),
        child: TextField(
          controller: provider.searchController,
          onChanged: (value) => provider.updateSearch(value),
          decoration: InputDecoration(
            hintText: "Search chats...",
            hintStyle: TextStyle(color: themeManager.textSecondary),
            prefixIcon: Icon(Icons.search, color: themeManager.primary),
            suffixIcon: provider.searchQuery.isNotEmpty
                ? IconButton(
              onPressed: () {
                provider.searchController.clear();
                provider.updateSearch("");
              },
              icon: Icon(Icons.clear, color: themeManager.textSecondary),
            )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(16),
              borderSide: BorderSide.none,
            ),
            filled: true,
            fillColor: themeManager.surface,
            contentPadding: const EdgeInsets.symmetric(vertical: 14),
          ),
          style: TextStyle(color: themeManager.text),
        ),
      ),
    );
  }

  // Online Users Section
  Widget _buildOnlineUsersSection(BuildContext context, ThemeManager themeManager) {
    final onlineUsers = [
      {"name": "John", "status": "online", "avatar": "JD"},
      {"name": "Sarah", "status": "online", "avatar": "SJ"},
      {"name": "Mike", "status": "away", "avatar": "MK"},
      {"name": "Lisa", "status": "online", "avatar": "LS"},
    ];

    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: onlineUsers.length,
        itemBuilder: (context, index) {
          final user = onlineUsers[index];
          return Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Column(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: themeManager.primary,
                          width: 2,
                        ),
                      ),
                      child: CircleAvatar(
                        radius: 28,
                        backgroundColor: themeManager.primary.withOpacity(0.1),
                        child: Text(
                          user["avatar"] ?? '',
                          style: TextStyle(
                            color: themeManager.primary,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 14,
                        width: 14,
                        decoration: BoxDecoration(
                          color: user["status"] == "online" ? Colors.green : Colors.orange,
                          border: Border.all(color: themeManager.surface, width: 2),
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  user["name"] ?? '',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: themeManager.text,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Chat List
  Widget _buildChatList(BuildContext context, ChatProvider provider, ThemeManager themeManager) {
    final chats = provider.filteredChats;

    if (chats.isEmpty) {
      return _buildEmptyState(themeManager);
    }

    return ListView.builder(
      itemCount: chats.length,
      itemBuilder: (context, index) {
        final chat = chats[index];
        return _buildChatItem(context, chat, provider, themeManager);
      },
    );
  }

  // Empty State
  Widget _buildEmptyState(ThemeManager themeManager) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.chat_bubble_outline, size: 80, color: themeManager.textSecondary),
          const SizedBox(height: 16),
          Text(
            "No chats found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: themeManager.text,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Start a new conversation",
            style: TextStyle(color: themeManager.textSecondary),
          ),
        ],
      ),
    );
  }

  // Chat Item
  Widget _buildChatItem(BuildContext context, Map<String, dynamic> chat, ChatProvider provider, ThemeManager themeManager) {
    return InkWell(
      onTap: () {
        provider.markAsRead(chat["id"]);
        provider.navigateTo(context, RouteNames.chatDetailsScreen, extra: chat);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            // Avatar
            Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: chat["online"] ? Colors.green : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: CircleAvatar(
                    radius: 28,
                    backgroundColor: themeManager.primary.withOpacity(0.1),
                    child: Text(
                      chat["avatar"],
                      style: TextStyle(
                        color: themeManager.primary,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
                if (chat["online"])
                  Positioned(
                    right: 2,
                    bottom: 2,
                    child: Container(
                      height: 12,
                      width: 12,
                      decoration: const BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),

            // Chat Info
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          chat["name"],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: themeManager.text,
                          ),
                        ),
                      ),
                      Text(
                        chat["time"],
                        style: TextStyle(
                          fontSize: 11,
                          color: themeManager.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      if (chat["group"] == true)
                        Icon(Icons.group, size: 14, color: themeManager.textSecondary),
                      if (chat["group"] == true) const SizedBox(width: 4),
                      Expanded(
                        child: Text(
                          chat["message"],
                          style: TextStyle(
                            fontSize: 13,
                            color: chat["unread"] > 0
                                ? themeManager.text
                                : themeManager.textSecondary,
                            fontWeight: chat["unread"] > 0
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  if (chat["typing"] == true)
                    const Padding(
                      padding: EdgeInsets.only(top: 4),
                      child: Text(
                        "Typing...",
                        style: TextStyle(
                          fontSize: 11,
                          color: Colors.green,
                          fontStyle: FontStyle.italic,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // Unread Badge
            if (chat["unread"] > 0)
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [themeManager.primary, themeManager.secondary],
                  ),
                  shape: BoxShape.circle,
                ),
                child: Text(
                  chat["unread"].toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

