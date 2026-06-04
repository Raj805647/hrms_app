import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_theme.dart';
import '../../../widget/help_widget.dart';
import 'task_provider.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeManager = Provider.of<ThemeManager>(context);

    return Consumer<TaskProvider>(
      builder: (context, provider, _) {
        return Scaffold(
          appBar: buildProfileAppBar(
            context: context,
            title: "My Tasks",
            action: [
              Container(
                margin: const EdgeInsets.only(right: 8),
                child: IconButton(
                  onPressed: (){},
                  icon: const Icon(Icons.filter_list, color: Colors.white),
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
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                _buildSummaryCards(provider, themeManager),
                const SizedBox(height: 20),
                _buildSearchBar(context, provider, themeManager),
                const SizedBox(height: 20),
                _buildTabs(provider, themeManager),
                const SizedBox(height: 20),
                _buildTaskList(provider, themeManager),
              ],
            ),
          ),
        );
      },
    );
  }


  // Floating Action Button
  Widget _buildFloatingActionButton(BuildContext context, ThemeManager themeManager) {
    return FloatingActionButton.extended(
      onPressed: () {},
      backgroundColor: themeManager.primary,
      icon: const Icon(Icons.add_task, color: Colors.white),
      label: const Text("New Task", style: TextStyle(color: Colors.white)),
    );
  }

  // Search Bar
  Widget _buildSearchBar(BuildContext context, TaskProvider provider, ThemeManager themeManager) {
    return Container(
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
        onChanged: (value) => provider.updateSearch(value),
        decoration: InputDecoration(
          hintText: "Search tasks...",
          hintStyle: TextStyle(color: themeManager.textSecondary),
          prefixIcon: Icon(Icons.search, color: themeManager.primary),
          suffixIcon: provider.searchQuery.isNotEmpty
              ? IconButton(
            onPressed: () => provider.updateSearch(""),
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
    );
  }

  // Summary Cards
  Widget _buildSummaryCards(TaskProvider provider, ThemeManager themeManager) {
    return Row(
      children: [
        Expanded(
          child: _buildCountCard(
            "Pending",
            "${provider.pendingCount}",
            Colors.orange,
            themeManager,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildCountCard(
            "In Progress",
            "${provider.inProgressCount}",
            Colors.blue,
            themeManager,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: _buildCountCard(
            "Completed",
            "${provider.completedCount}",
            Colors.green,
            themeManager,
          ),
        ),
      ],
    );
  }

  // Count Card
  Widget _buildCountCard(String title, String count, Color color, ThemeManager themeManager) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Column(
        children: [
          Text(
            count,
            style: TextStyle(
              color: color,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(color: themeManager.textSecondary, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // Tabs
  Widget _buildTabs(TaskProvider provider, ThemeManager themeManager) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.tabs.length,
        itemBuilder: (context, index) {
          final selected = provider.selectedTab == index;
          return GestureDetector(
            onTap: () => provider.changeTab(index),
            child: Container(
              margin: const EdgeInsets.only(right: 10),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: selected
                    ? LinearGradient(
                  colors: [themeManager.primary, themeManager.secondary],
                )
                    : null,
                color: selected ? null : themeManager.surface,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(
                  color: selected ? Colors.transparent : themeManager.textSecondary.withOpacity(0.2),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                "${provider.tabs[index]} (${_getTabCount(provider, index)})",
                style: TextStyle(
                  color: selected ? Colors.white : themeManager.text,
                  fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  // Get Tab Count
  int _getTabCount(TaskProvider provider, int index) {
    switch(index) {
      case 0: return provider.tasks.length;
      case 1: return provider.pendingCount;
      case 2: return provider.inProgressCount;
      case 3: return provider.completedCount;
      default: return 0;
    }
  }

  // Task List
  Widget _buildTaskList(TaskProvider provider, ThemeManager themeManager) {
    final tasks = provider.filteredTasks;

    if (tasks.isEmpty) {
      return _buildEmptyState(themeManager);
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: tasks.length,
      itemBuilder: (context, index) {
        final task = tasks[index];
        return _buildTaskCard(task, themeManager);
      },
    );
  }

  // Empty State
  Widget _buildEmptyState(ThemeManager themeManager) {
    return Container(
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: themeManager.surface,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          Icon(Icons.task_alt, size: 80, color: themeManager.textSecondary),
          const SizedBox(height: 16),
          Text(
            "No tasks found",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: themeManager.text,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "Try adjusting your search or filters",
            style: TextStyle(color: themeManager.textSecondary),
          ),
        ],
      ),
    );
  }

  // Task Card
  Widget _buildTaskCard(Map<String, dynamic> task, ThemeManager themeManager) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: themeManager.surface,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and Priority
          Row(
            children: [
              Expanded(
                child: Text(
                  task["title"],
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: themeManager.text,
                  ),
                ),
              ),
              _buildPriorityChip(task["priority"], themeManager),
            ],
          ),

          const SizedBox(height: 12),

          // Status Bar
          _buildStatusBar(task["status"], themeManager),

          const SizedBox(height: 12),

          // Assigned Info
          Row(
            children: [
              Icon(Icons.person_outline, size: 16, color: themeManager.textSecondary),
              const SizedBox(width: 4),
              Expanded(
                child: Text(
                  "Assigned by: ${task["assignedBy"]}",
                  style: TextStyle(fontSize: 13, color: themeManager.textSecondary),
                ),
              ),
            ],
          ),

          const SizedBox(height: 8),

          // Due Date
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16, color: themeManager.textSecondary),
              const SizedBox(width: 4),
              Text(
                "Due: ${task["dueDate"]}",
                style: TextStyle(fontSize: 13, color: _getDueDateColor(task["dueDate"], themeManager)),
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Description
          Text(
            task["description"],
            style: TextStyle(fontSize: 13, color: themeManager.textSecondary),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 12),

          // Stats and Actions
          Row(
            children: [
              _buildStatItem(Icons.comment, task["comments"], themeManager),
              const SizedBox(width: 16),
              _buildStatItem(Icons.attach_file, task["attachments"], themeManager),
              const Spacer(),
              TextButton(
                onPressed: () {},
                style: TextButton.styleFrom(
                  foregroundColor: themeManager.primary,
                ),
                child: const Text("View Details"),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // Priority Chip
  Widget _buildPriorityChip(String priority, ThemeManager themeManager) {
    Color color;
    switch (priority) {
      case "High":
        color = Colors.red;
        break;
      case "Medium":
        color = Colors.orange;
        break;
      default:
        color = Colors.green;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: color,
          fontSize: 11,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  // Status Bar
  Widget _buildStatusBar(String status, ThemeManager themeManager) {
    Color color;
    switch (status) {
      case "Pending":
        color = Colors.orange;
        break;
      case "In Progress":
        color = Colors.blue;
        break;
      default:
        color = Colors.green;
    }

    return Row(
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          status,
          style: TextStyle(
            color: color,
            fontSize: 12,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  // Stat Item
  Widget _buildStatItem(IconData icon, int count, ThemeManager themeManager) {
    return Row(
      children: [
        Icon(icon, size: 16, color: themeManager.textSecondary),
        const SizedBox(width: 4),
        Text(
          "$count",
          style: TextStyle(fontSize: 12, color: themeManager.textSecondary),
        ),
      ],
    );
  }

  // Get Due Date Color
  Color _getDueDateColor(String dueDate, ThemeManager themeManager) {
    // Simple logic - you can enhance this based on actual date comparison
    if (dueDate.contains("20 Jul") || dueDate.contains("18 Jul")) {
      return Colors.red;
    }
    return themeManager.textSecondary;
  }
}
