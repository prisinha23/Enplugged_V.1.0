import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';
import 'package:progress_dialog/progress_dialog.dart';

class PostDetailG extends StatefulWidget {
  PostDetailG({Key key}) : super(key: key);

  @override
  _PostDetailGState createState() => _PostDetailGState();
}

class _PostDetailGState extends State<PostDetailG> {
  void _showToast() =>
      ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(
          content: Text("Connected"),
          duration: Duration(
            milliseconds: 1000,
          )));

  ProgressDialog progressDialog;
  DocumentReference detailsI;
  String connectme = "Connect Me";
  String currentmailid = FirebaseAuth.instance.currentUser.email;

  static String name = "x", success = "0", since = "xxxx", about = "something";
  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: "Making the Arrangements..");
    final List<String> todo = ModalRoute.of(context).settings.arguments;
    String emailid = todo[0];
    String type = todo[1];
    detailsI = FirebaseFirestore.instance
        .collection(type)
        .doc(emailid)
        .collection('details')
        .doc(emailid);
    print(todo);
    return Scaffold(
        body: StreamBuilder(
            stream: detailsI.snapshots(),
            builder: (context, profile) {
              if (!profile.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
              name = profile.data["name"];
              about = profile.data["about"];
              since = profile.data["experienceinyear"].toString();
              success = profile.data["successpercentage"].toString();

              print(name);
              print(about);
              print(since);
              print(success);
              return SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [Colors.blue[900], Colors.blue[200]])),
                        child: Container(
                          width: double.infinity,
                          height: 350.0,
                          child: Center(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  backgroundImage: NetworkImage(
                                    "https://media.beam.usnews.com/d1/d8/8501ba714a21aed9a7327e02ade1/180515-10thingselonmusk-editorial.jpg",
                                  ),
                                  radius: 50.0,
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(
                                  name,
                                  style: TextStyle(
                                    fontSize: 22.0,
                                    color: Colors.white,
                                  ),
                                ),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Card(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20.0, vertical: 5.0),
                                  clipBehavior: Clip.antiAlias,
                                  color: Colors.white,
                                  elevation: 5.0,
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 22.0),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Success Score",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                "$success ",
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.blue,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            children: [
                                              Text(
                                                "Since",
                                                style: TextStyle(
                                                  color: Colors.blue,
                                                  fontSize: 22.0,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              SizedBox(
                                                height: 5.0,
                                              ),
                                              Text(
                                                since,
                                                style: TextStyle(
                                                  fontSize: 20.0,
                                                  color: Colors.blue,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        )),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 30.0, horizontal: 16.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "About:",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontStyle: FontStyle.normal,
                                  fontSize: 28.0),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              about,
                              style: TextStyle(
                                fontSize: 22.0,
                                fontStyle: FontStyle.italic,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                                letterSpacing: 2.0,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Container(
                      width: 300.00,
                      child: RaisedButton(
                          onPressed: () async {
                            progressDialog.show();
                            try {
                              await FirebaseFirestore.instance
                                  .collection("guide")
                                  .doc(currentmailid)
                                  .collection('connections')
                                  .doc(emailid)
                                  .set({
                                'name': name,
                                'email': emailid,
                                'type': type
                              });
                              connectme = "Connected";
                              progressDialog.update(
                                  message: "Sending Mail....");

                              String username = 'tedxsitech@gmail.com';
                              String password = 'tedx123456';
                              String mailname = name.toUpperCase();

                              final smtpServer = gmail(username, password);
                              final message = Message()
                                ..from = Address(
                                    "XXX@XXX.com", 'Enplugged Application')
                                ..recipients.add(currentmailid)
                                ..ccRecipients.addAll([username])
                                ..bccRecipients
                                    .add(Address('bccAddress@example.com'))
                                ..subject =
                                    '$mailname Added as New Enplugged Connections'
                                ..text =
                                    'Your Connection $mailname Mail Id \n :  $emailid \n\n\n\n Mail Sending Time: ${DateTime.now()}';

                              try {
                                final sendReport =
                                    await send(message, smtpServer);
                                print('Message sent: ' + sendReport.toString());
                              } on MailerException catch (e) {
                                print('Message not sent.');
                                for (var p in e.problems) {
                                  print('Problem: ${p.code}: ${p.msg}');
                                }
                              }
                              progressDialog.hide();
                              _showToast();
                            } catch (e) {
                              print(e);
                            }
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(80.0)),
                          elevation: 0.0,
                          padding: EdgeInsets.all(0.0),
                          child: Ink(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.centerRight,
                                  end: Alignment.centerLeft,
                                  colors: [Colors.blue[900], Colors.blue]),
                              borderRadius: BorderRadius.circular(30.0),
                            ),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth: 300.0, minHeight: 50.0),
                              alignment: Alignment.center,
                              child: Text(
                                connectme,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 26.0,
                                    fontWeight: FontWeight.w300),
                              ),
                            ),
                          )),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              );
            }));
  }
}
