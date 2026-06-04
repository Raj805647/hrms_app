import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/theme/app_theme.dart';
import '../../../core/utils.dart';
import '../../../widget/help_widget.dart';
import 'notification_provider.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<NotificationProvider>().init();
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Consumer<NotificationProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: buildProfileAppBar(
            isLeading: true,
            context: context,
            title: 'Notifications',
            action: [
              TextButton(
                onPressed: () => provider.markAllAsRead(),
                child: Text(
                  "Mark all read",
                  style: TextStyle(color: themeManager.primary),
                ),
              ),
              PopupMenuButton(
                icon: Icon(Icons.more_vert, color: themeManager.text),
                itemBuilder: (context) => [
                  const PopupMenuItem(
                    value: "settings",
                    child: Text("Notification Settings"),
                  ),
                  const PopupMenuItem(value: "clear", child: Text("Clear All")),
                ],
                onSelected: (value) {
                  if (value == "clear") {
                    _showClearDialog(context, provider);
                  }
                },
              ),
            ],
          ),
          body: Column(
            children: [
              _buildFilterChips(provider, themeManager),
              Expanded(child: _buildNotificationList(provider, themeManager)),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFilterChips(
    NotificationProvider provider,
    ThemeManager themeManager,
  ) {
    return Container(
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: provider.filterOptions.length,
        itemBuilder: (context, index) {
          final filter = provider.filterOptions[index];
          final isSelected = provider.selectedFilter == filter;

          return GestureDetector(
            onTap: () => provider.setFilter(filter),
            child: Container(
              margin: const EdgeInsets.only(right: 8),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? LinearGradient(
                        colors: [themeManager.primary, themeManager.secondary],
                      )
                    : null,
                color: isSelected ? null : themeManager.surface,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected
                      ? Colors.transparent
                      : themeManager.textSecondary.withOpacity(0.2),
                ),
              ),
              child: Center(
                child: Text(
                  filter,
                  style: TextStyle(
                    color: isSelected ? Colors.white : themeManager.text,
                    fontWeight: isSelected
                        ? FontWeight.w600
                        : FontWeight.normal,
                    fontSize: 13,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildNotificationList(
    NotificationProvider provider,
    ThemeManager themeManager,
  ) {
    final notifications = provider.filteredNotifications;

    if (notifications.isEmpty) {
      return _buildEmptyState(themeManager);
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: notifications.length,
      itemBuilder: (context, index) {
        final notification = notifications[index];
        return _buildNotificationCard(notification, provider, themeManager);
      },
    );
  }

  Widget _buildNotificationCard(
    Map<String, dynamic> notification,
    NotificationProvider provider,
    ThemeManager themeManager,
  ) {
    final isRead = notification['isRead'];
    final time = notification['time'] as DateTime;
    final difference = DateTime.now().difference(time);
    String timeAgo;

    if (difference.inDays > 0) {
      timeAgo = "${difference.inDays}d ago";
    } else if (difference.inHours > 0) {
      timeAgo = "${difference.inHours}h ago";
    } else if (difference.inMinutes > 0) {
      timeAgo = "${difference.inMinutes}m ago";
    } else {
      timeAgo = "Just now";
    }

    return Dismissible(
      key: Key(notification['id']),
      background: Container(
        color: Colors.red,
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        child: const Icon(Icons.delete, color: Colors.white),
      ),
      onDismissed: (direction) {
        provider.deleteNotification(notification['id']);
      },
      child: GestureDetector(
        onTap: () {
          if (!isRead) {
            provider.markAsRead(notification['id']);
          }
          _handleAction(context, notification);
        },
        child: Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: isRead
                ? themeManager.surface
                : themeManager.primary.withOpacity(0.05),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isRead
                  ? Colors.transparent
                  : themeManager.primary.withOpacity(0.3),
            ),
            boxShadow: [
              BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
            ],
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Icon
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: _getColor(
                    notification['color'],
                    themeManager,
                  ).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  notification['icon'],
                  color: _getColor(notification['color'], themeManager),
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),

              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            notification['title'],
                            style: TextStyle(
                              fontWeight: isRead
                                  ? FontWeight.w500
                                  : FontWeight.bold,
                              fontSize: 15,
                              color: themeManager.text,
                            ),
                          ),
                        ),
                        Text(
                          timeAgo,
                          style: TextStyle(
                            fontSize: 11,
                            color: themeManager.textSecondary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      notification['message'],
                      style: TextStyle(
                        fontSize: 13,
                        color: isRead
                            ? themeManager.textSecondary
                            : themeManager.text,
                      ),
                    ),
                    if (!isRead)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: BoxDecoration(
                            color: themeManager.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(ThemeManager themeManager) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.notifications_none,
            size: 80,
            color: themeManager.textSecondary.withOpacity(0.5),
          ),
          const SizedBox(height: 16),
          Text(
            "No notifications",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: themeManager.text,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "You're all caught up!",
            style: TextStyle(color: themeManager.textSecondary),
          ),
        ],
      ),
    );
  }

  void _showClearDialog(BuildContext context, NotificationProvider provider) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Clear All Notifications"),
        content: const Text(
          "Are you sure you want to clear all notifications?",
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              provider.clearAll();
              Navigator.pop(context);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Clear"),
          ),
        ],
      ),
    );
  }

  void _handleAction(BuildContext context, Map<String, dynamic> notification) {
    // Handle different notification actions
    switch (notification['action']) {
      case 'join_meeting':
        // Navigate to meeting
        break;
      case 'view_leave':
        // Navigate to leave details
        break;
      case 'view_task':
        // Navigate to task
        break;
      case 'mark_attendance':
        // Navigate to attendance
        break;
    }
  }

  Color _getColor(String color, ThemeManager themeManager) {
    switch (color) {
      case "blue":
        return Colors.blue;
      case "green":
        return Colors.green;
      case "orange":
        return Colors.orange;
      case "purple":
        return Colors.purple;
      case "red":
        return Colors.red;
      default:
        return themeManager.primary;
    }
  }
}
