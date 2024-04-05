import 'package:flutter/material.dart';
import 'package:hophseeflutter/ui/chatbot/chatscreen.dart';

class ChatBotWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 20,
      right: 20,
      child: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ChatScreen()), // Replace ChatBotScreen() with your actual chatbot screen
          );
        },
        backgroundColor: Colors.blue,
        child: Image.asset(
          'assets/googlelogo.png', // Replace this with your image asset path
          width: 24, // Adjust the width as needed
          height: 24, // Adjust the height as needed
          color: Colors.white, // Customize the image color if needed
        ),
      ),
    );
  }
}
