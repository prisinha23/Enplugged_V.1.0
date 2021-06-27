import 'package:enplugged/entrepreneur/registrationE.dart';
import 'package:enplugged/guide/registrationG.dart';
import 'package:enplugged/investor/registrationI.dart';
import 'package:enplugged/menu.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:progress_dialog/progress_dialog.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formkey = GlobalKey<FormState>();
  String valueChoose;
  String username;
  String emailid, password;

  ProgressDialog progressDialog;

  String enterpreneur = "entrepreneur";
  String investor = "investor";
  String guide = "guide";

  List listItem = [
    "Select your Profession",
    "Profession as Entrepreneur",
    "Profession as Investor",
    "Profession as Guide"
  ];
  @override
  Widget build(BuildContext context) {
    //important progress bar is here...
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: "Entering Your Data");

    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 20,
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Create an account, It's free ",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  )
                ],
              ),
              Form(
                key: _formkey,
                child: Column(
                  children: <Widget>[
                    Padding(
                        padding: EdgeInsets.symmetric(horizontal: 40),
                        child: Column(
                          children: <Widget>[
                            Padding(
                                padding: EdgeInsets.only(top: 3, left: 3),
                                child: Container(
                                    height: 60,
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(50),
                                        border: Border.all(color: Colors.black),
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.transparent,
                                            offset: Offset(0.0, 1.0), //(x,y)
                                            blurRadius: 6.0,
                                          ),
                                        ]),
                                    child: DropdownButtonHideUnderline(
                                        child: Center(
                                      child: DropdownButton(
                                        iconEnabledColor: Colors.transparent,
                                        hint: Text(
                                          "Select Your Profession",
                                        ),
                                        dropdownColor: Colors.white,
                                        value: valueChoose,
                                        onChanged: (newValue) {
                                          setState(() {
                                            valueChoose = newValue;
                                          });
                                        },
                                        items: listItem.map((valueItem) {
                                          return DropdownMenuItem(
                                              value: valueItem,
                                              child: Center(
                                                child: Text(
                                                  valueItem,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ));
                                        }).toList(),
                                      ),
                                    )))),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Fill this Section';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                username = value;
                              },
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.verified_user),
                                  labelText: 'Username',
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
                                      borderSide:
                                          BorderSide(color: Colors.black))),
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
                                emailid = value;
                              },
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.email),
                                  labelText: 'Email',
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
                                      borderSide:
                                          BorderSide(color: Colors.black))),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Fill this Section';
                                } else if (value.length < 6) {
                                  return 'Minimum 6 letters Needed';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                password = value;
                              },
                              obscureText: true,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.security),
                                  labelText: 'Password',
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
                                      borderSide:
                                          BorderSide(color: Colors.black))),
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
                                  minWidth: double.infinity,
                                  height: 60,
                                  onPressed: () async {
                                    progressDialog.show();
                                    if ((valueChoose == null ||
                                        valueChoose ==
                                            "Select your Profession")) {
                                      showDialog(
                                          context: context,
                                          builder: (BuildContext context) =>
                                              AlertDialog(
                                                title: Text(
                                                    'Profession is not selected'),
                                                content: Text(
                                                    'Select a Profession to SignUp'),
                                              ));
                                      print("no entry");
                                    } else if (_formkey.currentState
                                        .validate()) {
//entrepreneur section is here.....

                                      if (valueChoose ==
                                          "Profession as Entrepreneur") {
                                        try {
                                          print('entery');
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: emailid,
                                                  password: password);
                                          progressDialog.update(
                                              message:
                                                  "Authentication Done \n Now Storing Data..");
                                          await FirebaseFirestore.instance
                                              .collection(enterpreneur)
                                              .doc(emailid)
                                              .set({
                                            'username': username,
                                            'email': emailid,
                                            'password': password,
                                            'section': enterpreneur
                                          });
                                          progressDialog.hide();
                                          print('Enter Entrepreneur');
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegistrationEntrepreneur()));
                                        } catch (e) {
                                          progressDialog.hide();
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: Text(
                                                        'Error During Registration'),
                                                    content: Text(
                                                        'Could Not Register:$e'),
                                                  ));
                                        }
                                      }

                                      //investor section and registration....

                                      else if (valueChoose ==
                                          "Profession as Investor") {
                                        try {
                                          print('entery');
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: emailid,
                                                  password: password);
                                          progressDialog.update(
                                              message:
                                                  "Authentication Done \n Now Storing Data..");
                                          await FirebaseFirestore.instance
                                              .collection(investor)
                                              .doc(emailid)
                                              .set({
                                            'username': username,
                                            'email': emailid,
                                            'password': password,
                                            'section': investor
                                          });
                                          progressDialog.hide();
                                          print('Enter Entrepreneur');
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegisterInvestor()));
                                        } catch (e) {
                                          progressDialog.hide();
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: Text(
                                                        'Error During Registration'),
                                                    content: Text(
                                                        'Could Not Register:$e'),
                                                  ));
                                        }
                                      }

                                      //guide Section....

                                      else if (valueChoose ==
                                          "Profession as Guide") {
                                        try {
                                          print('entery');
                                          await FirebaseAuth.instance
                                              .createUserWithEmailAndPassword(
                                                  email: emailid,
                                                  password: password);
                                          progressDialog.update(
                                              message:
                                                  "Authentication Done \n Now Storing Data..");
                                          await FirebaseFirestore.instance
                                              .collection(guide)
                                              .doc(emailid)
                                              .set({
                                            'username': username,
                                            'email': emailid,
                                            'password': password,
                                            'section': guide
                                          });
                                          progressDialog.hide();
                                          print('Enter Entrepreneur');
                                          Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      RegistrationGuide()));
                                        } catch (e) {
                                          progressDialog.hide();
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertDialog(
                                                    title: Text(
                                                        'Error During Registration'),
                                                    content: Text(
                                                        'Could Not Register:$e'),
                                                  ));
                                        }
                                      }
                                    }
                                  },
                                  color: Color(0xff0095FF),
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    "Sign up",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Already have an account?"),
                  MaterialButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => Menu()));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
