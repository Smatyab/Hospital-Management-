import 'package:flutter/material.dart';

class NotificationItem {
  final String title;
  final String subtitle;
  final String avatarUrl;
  final IconData iconData;
  final Color iconColor;

  NotificationItem({
    required this.title,
    required this.subtitle,
    required this.avatarUrl,
    required this.iconData,
    required this.iconColor,
  });
}

class NotificationPanel extends StatelessWidget {
  final List<NotificationItem> notifications = [
    NotificationItem(
      title: 'Appointment Reminder',
      subtitle: 'Dr. Smith - Cardiology | Tomorrow at 2:00 PM',
      avatarUrl:
          'https://placekitten.com/50/50', // Replace with actual user avatar URLs
      iconData: Icons.calendar_today,
      iconColor: Colors.blue,
    ),
    NotificationItem(
      title: 'New Test Results',
      subtitle: 'Your test results are ready for review',
      avatarUrl: 'https://placekitten.com/51/51',
      iconData: Icons.assignment,
      iconColor: Colors.green,
    ),
    // Add more notifications as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
              elevation: 3,
              child: ListTile(
                contentPadding: EdgeInsets.all(16.0),
                leading: CircleAvatar(
                  radius: 24.0,
                  backgroundImage: NetworkImage(notifications[index].avatarUrl),
                ),
                title: Text(
                  notifications[index].title,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(notifications[index].subtitle),
                trailing: Icon(
                  notifications[index].iconData,
                  color: notifications[index].iconColor,
                ),
                onTap: () {
                  // Handle tap on notification item
                  print('Notification Tapped: ${notifications[index].title}');
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationPanel(),
                    ),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
