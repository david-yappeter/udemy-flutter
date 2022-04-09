import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class NewMessage extends StatefulWidget {
  const NewMessage({Key? key}) : super(key: key);

  @override
  _NewMessageState createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  final _fieldMessage = TextEditingController();

  void _sendMessage() async {
    final user = FirebaseAuth.instance.currentUser;
    final userData = await FirebaseFirestore.instance
        .collection('users')
        .doc(user?.uid)
        .get();
    FirebaseFirestore.instance.collection('chats').add({
      'text': _fieldMessage.text,
      'createdAt': Timestamp.now(),
      'userId': user?.uid,
      'username': userData.data()!['username'],
    });
    _fieldMessage.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 8.0),
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              keyboardType: TextInputType.multiline,
              minLines: 1,
              maxLines: 3,
              decoration:
                  const InputDecoration(labelText: 'Send a Message . . .'),
              controller: _fieldMessage,
              onChanged: (_) {
                setState(() {});
              },
            ),
          ),
          IconButton(
            color: Theme.of(context).primaryColor,
            icon: const Icon(Icons.send),
            onPressed: _fieldMessage.text.trim().isEmpty ? null : _sendMessage,
          ),
        ],
      ),
    );
  }
}
