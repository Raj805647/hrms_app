import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../widget/help_widget.dart';
import 'task_provider.dart';

class TaskScreen extends StatelessWidget {
  const TaskScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<TaskProvider>(
      builder: (_, provider, __) {

        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            title: const Text(
              "Tasks",
            ),
          ),

          floatingActionButton:
          FloatingActionButton.extended(
            onPressed: () {},
            icon: const Icon(
              Icons.add_task,
            ),
            label: const Text(
              "New Task",
            ),
          ),

          body: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [

                _buildSummaryCards(),

                spaceHeight(20),

                _buildTabs(provider),

                spaceHeight(20),

                _buildTaskList(provider),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildSummaryCards() {
    return Row(
      children: [

        Expanded(
          child: _buildCountCard(
            "Pending",
            "08",
            Colors.orange,
          ),
        ),

        spaceWidth(10),

        Expanded(
          child: _buildCountCard(
            "Progress",
            "03",
            Colors.blue,
          ),
        ),

        spaceWidth(10),

        Expanded(
          child: _buildCountCard(
            "Completed",
            "25",
            Colors.green,
          ),
        ),
      ],
    );
  }

  Widget _buildCountCard(
      String title,
      String count,
      Color color,
      ) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: color.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [

          Text(
            count,
            style: TextStyle(
              color: color,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),

          Text(title),
        ],
      ),
    );
  }

  Widget _buildTabs(
      TaskProvider provider,
      ) {
    return SizedBox(
      height: 45,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: provider.tabs.length,
        itemBuilder: (_, index) {

          final selected =
              provider.selectedTab == index;

          return GestureDetector(
            onTap: () {
              provider.changeTab(index);
            },
            child: Container(
              margin:
              const EdgeInsets.only(
                right: 10,
              ),
              padding:
              const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              decoration: BoxDecoration(
                color: selected
                    ? AppColors.primary
                    : Colors.grey.shade200,
                borderRadius:
                BorderRadius.circular(
                  100,
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                provider.tabs[index],
                style: TextStyle(
                  color: selected
                      ? Colors.white
                      : Colors.black,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
  Widget _buildTaskList(
      TaskProvider provider,
      ) {
    return ListView.builder(
      shrinkWrap: true,
      physics:
      const NeverScrollableScrollPhysics(),
      itemCount: provider.tasks.length,
      itemBuilder: (_, index) {

        final task =
        provider.tasks[index];

        return _buildTaskCard(task);
      },
    );
  }

  Widget _buildTaskCard(
      Map<String, dynamic> task,
      ) {
    return Container(
      margin:
      const EdgeInsets.only(
        bottom: 16,
      ),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        borderRadius:
        BorderRadius.circular(24),
        color: Colors.white38,
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [

          Row(
            children: [

              Expanded(
                child: Text(
                  task["title"],
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight:
                    FontWeight.bold,
                  ),
                ),
              ),

              _buildPriorityChip(
                task["priority"],
              ),
            ],
          ),

          spaceHeight(15),

          Text(
            "Assigned By: ${task["assignedBy"]}",
          ),

          spaceHeight(8),

          Text(
            "Due Date: ${task["dueDate"]}",
          ),

          spaceHeight(15),

          Row(
            children: [

              Icon(
                Icons.comment,
                size: 18,
              ),

              spaceWidth(5),

              Text(
                "${task["comments"]}",
              ),

              spaceWidth(20),

              Icon(
                Icons.attach_file,
                size: 18,
              ),

              spaceWidth(5),

              Text(
                "${task["attachments"]}",
              ),

              const Spacer(),

              TextButton(
                onPressed: () {},
                child: const Text(
                  "Details",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildPriorityChip(
      String priority,
      ) {

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
      padding:
      const EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(.15),
        borderRadius:
        BorderRadius.circular(100),
      ),
      child: Text(
        priority,
        style: TextStyle(
          color: color,
        ),
      ),
    );
  }


}

