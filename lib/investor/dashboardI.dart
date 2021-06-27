import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enplugged/investor/connections.dart';
import 'package:enplugged/investor/detailsI.dart';
import 'package:enplugged/investor/post.dart';
import 'package:enplugged/investor/postDetail.dart';
import 'package:enplugged/investor/updateI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:intl/intl.dart';

class DashboardI extends StatefulWidget {
  DashboardI({Key key}) : super(key: key);

  @override
  _DashboardIState createState() => _DashboardIState();
}

class _DashboardIState extends State<DashboardI> {
  ProgressDialog progressDialog;
  static String name = "1",
      sucess = "1",
      since = "1",
      turnover = "1",
      namepost = "x";

  static String typesearch, mailidsearch;

//database section using Firebase Firestore .....for Enplugged....
  int _selectedIndex = 0;
  static final _formkey = GlobalKey<FormState>();
  static String emailfake = "asdsad@asd.asd";
  static String email = FirebaseAuth.instance.currentUser.email;
  static DocumentReference profiledatabase = FirebaseFirestore.instance
      .collection('investor')
      .doc(email)
      .collection('details')
      .doc(email);

  static String postmailid, postmadeby;
  static List<String> notes;

//database section........
  static final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('post').snapshots();

  static final Stream<QuerySnapshot> _entrepreneurAll =
      FirebaseFirestore.instance.collection('entrepreneurAll').snapshots();

  static final Stream<QuerySnapshot> _guideAll =
      FirebaseFirestore.instance.collection('guideAll').snapshots();

  List<Widget> _widgetOptions = <Widget>[
    StreamBuilder<QuerySnapshot>(
      stream: _usersStream,
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
                        backgroundColor: Colors.blue,
                        child: new Text(
                          data['alphabet'].toString(),
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                      title: new Text(
                        data['name'].toString(),
                        style: TextStyle(color: Colors.blue, fontSize: 19),
                      ),
                      subtitle: new Text(
                        data['post'].toString(),
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      onTap: () {
                        postmailid = data['email'].toString();
                        postmadeby = data['type'].toString();
                        notes = [postmailid, postmadeby];
                        print(postmailid);
                        print(postmadeby);
                        print(data['post'].toString());
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostDetail(),
                                settings: RouteSettings(
                                  arguments: notes,
                                )));
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Text(data['date'].toString(),
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
    ),
    //Entrepreneur Section...

    StreamBuilder<QuerySnapshot>(
      stream: _entrepreneurAll,
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
            Color indi;
            double sucesindi = double.parse(data['successpercentage']);
            double failindi = double.parse(data['failpercentage']);
            String aboutentre = data['about'].toString();
            String profitmade = data['successpercentage'].toString();
            String funding = data['fundingamount'].toString();
            String report;
            if (profitmade == "1") {
              report = "High";
            } else {
              report = "Low";
            }
            if (sucesindi > failindi) {
              indi = Colors.green[200];
            } else {
              indi = Colors.red[200];
            }
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: indi,
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
                        backgroundColor: indi,
                        child: new Text(
                          data['alphabet'].toString(),
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      title: new Text(
                        data['name'].toString(),
                        style: TextStyle(color: Colors.blue, fontSize: 19),
                      ),
                      subtitle: new Text(
                        "$aboutentre \n \n Success Chance:$report  \n Funding Amount:Rs.$funding \n",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      onTap: () {
                        postmailid = data['email'];
                        postmadeby = data['type'];
                        notes = [postmailid, postmadeby];
                        print(postmailid);
                        print(postmadeby);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostDetail(),
                                settings: RouteSettings(
                                  arguments: notes,
                                )));
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Text(data['experienceinyear'].toString(),
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
    ),

//Guide Section  ........
    StreamBuilder<QuerySnapshot>(
      stream: _guideAll,
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
            Color indi;
            double sucesindi = double.parse(data['successpercentage']);
            double failindi = double.parse(data['failurepercentage']);
            String aboutentre = data['about'];
            String profitmade = data['successpercentage'];
            String funding = data['totalstartup'].toString();
            if (sucesindi > failindi) {
              indi = Colors.green[200];
            } else {
              indi = Colors.red[200];
            }
            return Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  boxShadow: [
                    BoxShadow(
                      color: indi,
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
                        backgroundColor: indi,
                        child: new Text(
                          data['alphabet'],
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      title: new Text(
                        data['name'],
                        style: TextStyle(color: Colors.blue, fontSize: 19),
                      ),
                      subtitle: new Text(
                        "$aboutentre \n \n SuccessScore:$profitmade % \n Total Guided Startups:$funding \n",
                        style: TextStyle(color: Colors.black, fontSize: 15),
                      ),
                      onTap: () {
                        postmailid = data['email'];
                        postmadeby = data['type'];
                        notes = [postmailid, postmadeby];
                        print(postmailid);
                        print(postmadeby);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => PostDetail(),
                                settings: RouteSettings(
                                  arguments: notes,
                                )));
                      },
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        new Text(data['experienceinyear'].toString(),
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
    ),

    ////Search  section
    ///
    ///
    ///
    StreamBuilder(
      stream: profiledatabase.snapshots(),
      builder: (context, data) {
        return Padding(
          padding: EdgeInsets.fromLTRB(1, 50, 2, 2),
          child: Column(
            children: <Widget>[
              Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Fill this Section';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        typesearch = value;
                      },
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.verified_user),
                          labelText: 'Field To Search For',
                          labelStyle: TextStyle(
                            fontSize: 19,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 25,
                            horizontal: 25,
                          ),
                          focusColor: Color(0xff0962ff),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Empty Section';
                        } else if (!RegExp(
                                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                            .hasMatch(value.toString())) {
                          return 'Enter a Valid Email';
                        }
                        return null;
                      },
                      onChanged: (value) {
                        mailidsearch = value;
                      },
                      style: TextStyle(
                          fontSize: 19,
                          color: Colors.blue,
                          fontWeight: FontWeight.bold),
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          labelText: 'Enter his Registered Email',
                          labelStyle: TextStyle(
                            fontSize: 19,
                            color: Colors.black,
                            fontWeight: FontWeight.w600,
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 27,
                            horizontal: 25,
                          ),
                          focusColor: Color(0xff0962ff),
                          focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(25),
                              borderSide: BorderSide(color: Colors.black))),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Container(
                            padding: EdgeInsets.only(top: 3, left: 3),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                                border: Border(
                                  bottom: BorderSide(color: Colors.black),
                                  top: BorderSide(color: Colors.black),
                                  left: BorderSide(color: Colors.black),
                                  right: BorderSide(color: Colors.black),
                                )),
                            child: MaterialButton(
                                color: Color(0xff0095FF),
                                elevation: 1,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                child: Text(
                                  "Search",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                ),
                                minWidth: double.infinity,
                                height: 60,
                                onPressed: () {
                                  if (_formkey.currentState.validate()) {
                                    notes = [mailidsearch, typesearch];
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PostDetail(),
                                            settings: RouteSettings(
                                              arguments: notes,
                                            )));
                                  }
                                })))
                  ],
                ),
              ),
            ],
          ),
        );
      },
    ),
    //profile Section
    //

    //profile Section
    //
    StreamBuilder(
        stream: profiledatabase.snapshots(),
        builder: (context, profile) {
          if (!profile.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          name = profile.data["name"].toString().toUpperCase();
          namepost = name;
          turnover = profile.data["totalturnover"];

          since = profile.data["experienceinyear"];
          sucess = profile.data["successpercentage"];

          print(name);
          print(namepost);
          print(turnover);
          print(since);
          print(sucess);
          return SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [Colors.blue[900], Colors.blue[200]])),
                    child: Container(
                      width: double.infinity,
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              height: 40.0,
                            ),
                            CircleAvatar(
                              backgroundImage: NetworkImage(
                                "https://pngimg.com/uploads/letter_i/letter_i_PNG44.png",
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
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => DetailsI()));
                                },
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 8.0, vertical: 22.0),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Text(
                                              "TurnOver",
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
                                              turnover,
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
                                              "Success",
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
                                              sucess,
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
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            )
                          ],
                        ),
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.fromLTRB(1, 20, 2, 2),
                  child: Column(
                    children: <Widget>[
                      Card(
                        color: Colors.indigo.shade600,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://www.fiveblocks.com/wp-content/uploads/2018/01/edit-wikipedia.png'),
                              ),
                              title: Text('Edit Your Profile',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Lobster")),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                const SizedBox(width: 8),
                                RaisedButton(
                                  color: Colors.white,
                                  child: const Text('Edit',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Lobster")),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => UpdateI()));
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Card(
                        color: Colors.indigo.shade600,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://aneliteresume.com/wp-content/uploads/2019/09/Make-Connections-When-You-Don%E2%80%99t-Have-the-Natural-%E2%80%9CIn%E2%80%9D.jpg'),
                              ),
                              title: Text('Connections Made',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Lobster")),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                const SizedBox(width: 8),
                                RaisedButton(
                                  color: Colors.white,
                                  child: const Text('View',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Lobster")),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ConnectionsI()));
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Card(
                        color: Colors.indigo.shade600,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const ListTile(
                              leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    'https://www.masscommunicationtalk.com/wp-content/uploads/2016/02/writing-1.jpg'),
                              ),
                              title: Text('Posts Made',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "Lobster")),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: <Widget>[
                                SizedBox(
                                  width: 20,
                                ),
                                const SizedBox(width: 8),
                                RaisedButton(
                                  color: Colors.white,
                                  child: const Text('View',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontFamily: "Lobster")),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => PostI()));
                                  },
                                ),
                                const SizedBox(width: 8),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 70,
                )
              ],
            ),
          );
        })
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _showToast() =>
      ScaffoldMessenger.of(this.context).showSnackBar(const SnackBar(
          content: Text("Posted"),
          duration: Duration(
            milliseconds: 1000,
          )));
  String now = DateFormat("dd-MM-yyyy ").format(DateTime.now());
  String postmade;
  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: "Loading Data...");
    return Scaffold(
        body: Center(
            child: Padding(
          padding: EdgeInsets.symmetric(),
          child: _widgetOptions.elementAt(_selectedIndex),
        )),
        bottomNavigationBar: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                  icon: Icon(Icons.featured_play_list),
                  title: Text('Post'),
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.engineering),
                  title: Text('Entrepreneur'),
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.assistant_navigation),
                  title: Text('Guide'),
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  title: Text('Search'),
                  backgroundColor: Colors.blue),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text('Profile'),
                backgroundColor: Colors.blue,
              ),
            ],
            type: BottomNavigationBarType.shifting,
            currentIndex: _selectedIndex,
            selectedItemColor: Colors.black,
            iconSize: 25,
            onTap: _onItemTapped,
            elevation: 5),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.blue,
          onPressed: () {
            progressDialog.show();
            showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                      title: Text(
                        'Post Your Thoughts',
                        style: TextStyle(color: Colors.blue),
                      ),
                      content: TextFormField(
                        maxLines: 3,
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Fill this Section';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          postmade = value;
                        },
                        style: TextStyle(
                            fontSize: 19,
                            color: Colors.blue,
                            fontWeight: FontWeight.bold),
                        decoration: InputDecoration(
                            labelText: "Thought Section",
                            labelStyle: TextStyle(
                              fontSize: 19,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 25,
                              horizontal: 25,
                            ),
                            focusColor: Color(0xff0962ff),
                            focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15),
                                borderSide: BorderSide(color: Colors.blue))),
                      ),
                      actions: <Widget>[
                        // ignore: deprecated_member_use
                        OutlineButton(
                          onPressed: () async {
                            progressDialog.show();
                            progressDialog.update(
                                message: "Post What Keeps us Connected");
                            print(now);
                            print(postmade);
                            print(email);
                            print(namepost);
                            try {
                              await FirebaseFirestore.instance
                                  .collection('post')
                                  .add({
                                'date': now,
                                'post': postmade,
                                'name': namepost,
                                'email': email,
                                'type': 'investor',
                                'alphabet': "I"
                              });
                              progressDialog.update(message: "Almost Posted..");
                              await FirebaseFirestore.instance
                                  .collection('investor')
                                  .doc(email)
                                  .collection('post')
                                  .add({
                                'date': now,
                                'post': postmade,
                                'name': namepost,
                                'email': email,
                                'type': 'investor',
                                'alphabet': "I"
                              });
                              progressDialog.hide();
                              _showToast();
                            } catch (e) {
                              progressDialog.hide();
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertDialog(
                                        title:
                                            Text('Error During Registration'),
                                        content: Text('Could Not Register:$e'),
                                      ));
                            }
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Post',
                            style: TextStyle(color: Colors.blue),
                          ),
                        )
                      ],
                    ));
          },
          child: const Icon(Icons.edit),
        ));
  }
}
