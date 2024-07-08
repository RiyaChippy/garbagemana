import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:garbagemana/admin/profile.dart';

class UserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.fill,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(19.0),
              child: Text(
                'User List',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 251, 251, 252),
                ),
              ),
            ),
            Expanded(
              child: UserList(),
            ),
          ],
        ),
      ),
    );
  }
}

class UserList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        List<DocumentSnapshot> docs = snapshot.data!.docs;
        return ListView.builder(
          itemCount: docs.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data =
                docs[index].data() as Map<String, dynamic>;
            return UserCard(data: data, documentId: docs[index].id);
          },
        );
      },
    );
  }
}

class UserCard extends StatelessWidget {
  final Map<String, dynamic> data;
  final String documentId;

  UserCard({required this.data, required this.documentId});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: ListTile(
        title: Text(data['name'] ?? ''),
        subtitle: Text(data['email'] ?? ''),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProfilePage(),
            ),
          );
        },
        trailing: Switch(
          value: data['isWorker'] ?? false,
          onChanged: (value) {
            _updateWorkerStatus(context, documentId, value, data);
          },
        ),
      ),
    );
  }

  void _updateWorkerStatus(BuildContext context, String documentId,
      bool isWorker, Map<String, dynamic> data) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .update({'isWorker': isWorker}).then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Worker status updated!')),
      );

      // Add or remove user from the "workers" collection
      if (isWorker) {
        // If user is marked as a worker, add them to the "workers" collection
        FirebaseFirestore.instance
            .collection('workers')
            .doc(documentId)
            .set(data);
      } else {
        // If user is not a worker, remove them from the "workers" collection
        FirebaseFirestore.instance
            .collection('workers')
            .doc(documentId)
            .delete();
      }
    }).catchError((error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update worker status: $error')),
      );
    });
  }
}
