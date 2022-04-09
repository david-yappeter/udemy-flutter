import 'package:flutter/material.dart';

class MessageBubble extends StatelessWidget {
  final String username;
  final String message;
  final bool isMe;
  const MessageBubble({
    Key? key,
    required this.username,
    required this.message,
    required this.isMe,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const radius = Radius.circular(20);
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          decoration: BoxDecoration(
            color: !isMe
                ? Colors.grey[200]
                : Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.only(
              topLeft: radius,
              topRight: radius,
              bottomLeft: !isMe ? const Radius.circular(0) : radius,
              bottomRight: isMe ? const Radius.circular(0) : radius,
            ),
          ),
          width: 140,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 16,
          ),
          margin: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 8,
          ),
          child: Column(
            crossAxisAlignment:
                isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
            children: [
              Text(
                username,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: !isMe ? Colors.black : Colors.white,
                ),
              ),
              Text(
                message,
                style: TextStyle(color: !isMe ? Colors.black : Colors.white),
                textAlign: isMe ? TextAlign.end : TextAlign.start,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
