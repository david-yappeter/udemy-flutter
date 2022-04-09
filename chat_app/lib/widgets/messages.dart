import 'package:chat_app/widgets/message_bubble.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Messages extends StatelessWidget {
  const Messages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance
          .collection('chats')
          .orderBy(
            'createdAt',
            descending: true,
          )
          .snapshots(),
      builder: (BuildContext ctx,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error!'));
        }

        final documents = snapshot.data?.docs;

        return ListView.builder(
          reverse: true,
          itemCount: documents?.length,
          itemBuilder: (BuildContext ctx, int index) => MessageBubble(
            key: ValueKey(documents?[index].id),
            message: documents?[index]['text'],
            isMe: documents?[index]['userId'] == user?.uid,
            username: documents?[index]['username'],
            image: documents?[index]['userImage'],
          ),
        );
      },
    );
  }
}
