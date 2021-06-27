import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class ConnectionsI extends StatefulWidget {
  ConnectionsI({Key key}) : super(key: key);

  @override
  _ConnectionsIState createState() => _ConnectionsIState();
}

class _ConnectionsIState extends State<ConnectionsI> {
  static String currentuser = FirebaseAuth.instance.currentUser.email;
  Stream<QuerySnapshot> connections = FirebaseFirestore.instance
      .collection('investor')
      .doc(currentuser)
      .collection('connections')
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: connections,
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView(
          children: snapshot.data.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white,
                      offset: Offset(0.0, 1.0), //(x,y)
                      blurRadius: 6.0,
                    ),
                  ]),
              child: Card(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.green,
                        child: new Text(
                          "C",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      title: new Text(
                        data['name'],
                        style: TextStyle(color: Colors.blue, fontSize: 19),
                      ),
                      subtitle: new Text(
                        data['email'],
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      onTap: () {},
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Text(data['type'],
                            style: TextStyle(color: Colors.grey[700])),
                        const SizedBox(width: 8),
                        const SizedBox(width: 8),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    )
                  ],
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
