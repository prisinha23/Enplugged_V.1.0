import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enplugged/investor/dashboardI.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';

class RegisterInvestor extends StatefulWidget {
  RegisterInvestor({Key key}) : super(key: key);

  @override
  _RegisterInvestorState createState() => _RegisterInvestorState();
}

class _RegisterInvestorState extends State<RegisterInvestor> {
  ProgressDialog progressDialog;
  String name, number, link, year, totalturnover, about;
  int totalstartupinvestedin, successfullinvestment, failedinvestment;

  final _formkey = GlobalKey<FormState>();
  String valueChoose;
  String valueKind;
  String status;
  String valueyesno;
  String valueyesno2;

  var spercent, fpercent;
  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: "Loading Your Data....");
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
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Text(
                    "Welcome Investor..",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Register You Firm And Get Best Connections",
                    style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                  ),
                  SizedBox(
                    height: 5,
                  ),
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
                            SizedBox(
                              height: 14,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Fill this Section';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                name = value;
                              },
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: 'Organization Name',
                                  prefixIcon: Icon(Icons.apartment),
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
                              height: 14,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Fill this Section';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                about = value;
                              },
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: 'About',
                                  prefixIcon: Icon(Icons.verified_user),
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
                              height: 14,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Empty Section';
                                } else if (value.length != 10) {
                                  return 'Invalid Number';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                number = value;
                              },
                              keyboardType: TextInputType.phone,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: 'Contact Number',
                                  prefixIcon: Icon(Icons.phone),
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
                              height: 14,
                            ),
                            TextFormField(
                              onChanged: (value) {
                                link = value;
                              },
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: 'Organization Website Link',
                                  prefixIcon: Icon(Icons.link),
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
                              height: 14,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Fill this Section';
                                } else if (value.length != 4) {
                                  return 'Enter a valid Year';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                year = value;
                              },
                              keyboardType: TextInputType.datetime,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: "In Business Since YYYY",
                                  prefixIcon: Icon(Icons.calendar_today),
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
                              height: 14,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Fill this Section';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                totalturnover = value;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: "Total TurnOver Of Firm",
                                  prefixIcon: Icon(Icons.money),
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
                              height: 14,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Fill this Section';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                totalstartupinvestedin = int.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: "Total Startups Invested In",
                                  prefixIcon: Icon(Icons.add),
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
                              height: 14,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Fill this Section';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                successfullinvestment = int.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: "Successfull Startups Count",
                                  prefixIcon: Icon(Icons.arrow_upward_sharp),
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
                              height: 14,
                            ),
                            TextFormField(
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Fill this Section';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                failedinvestment = int.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: "Failed Startups Count",
                                  prefixIcon: Icon(Icons.arrow_downward_sharp),
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
                              height: 14,
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
                                    if (_formkey.currentState.validate()) {
                                      try {
                                        var email = await FirebaseAuth
                                            .instance.currentUser.email;

                                        progressDialog.update(
                                            message:
                                                "Calculating Your Success and Failure Percentage");

                                        if (totalstartupinvestedin != 0 &&
                                            successfullinvestment <
                                                totalstartupinvestedin &&
                                            failedinvestment <
                                                totalstartupinvestedin) {
                                          spercent = (successfullinvestment /
                                                  totalstartupinvestedin) *
                                              100;
                                          fpercent = (failedinvestment /
                                                  totalstartupinvestedin) *
                                              100;
                                        } else {
                                          spercent = 0;
                                          fpercent = 0;
                                        }
                                        Color color;
                                        if (spercent > fpercent) {
                                          color = Colors.green[600];
                                        } else {
                                          color = Colors.red[700];
                                        }
                                        spercent = spercent.toStringAsFixed(2);

                                        fpercent = fpercent.toStringAsFixed(2);

                                        String sucstring =
                                            "Your Success Rate is:$spercent";
                                        progressDialog.update(
                                            message: "Entering Your Data");

                                        await FirebaseFirestore.instance
                                            .collection("investor")
                                            .doc(email)
                                            .collection('details')
                                            .doc(email)
                                            .set({
                                          'name': name,
                                          'contactnumber': number,
                                          'link': link,
                                          'experienceinyear': year,
                                          'totalturnover': totalturnover,
                                          'totalinvestedin':
                                              totalstartupinvestedin,
                                          'successfulstartup':
                                              successfullinvestment,
                                          'failedstartup': failedinvestment,
                                          'successpercentage': spercent,
                                          'failurepercentage': fpercent,
                                          'about': about,
                                          'email': email,
                                          'type': "investor",
                                          'alphabet': "I"
                                        });

                                        progressDialog.update(
                                            message: "And Finalizing..");

                                        await FirebaseFirestore.instance
                                            .collection("investorAll")
                                            .doc(email)
                                            .set({
                                          'name': name,
                                          'contactnumber': number,
                                          'link': link,
                                          'experienceinyear': year,
                                          'totalturnover': totalturnover,
                                          'totalinvestedin':
                                              totalstartupinvestedin,
                                          'successfulstartup':
                                              successfullinvestment,
                                          'failedstartup': failedinvestment,
                                          'successpercentage': spercent,
                                          'failurepercentage': fpercent,
                                          'about': about,
                                          'email': email,
                                          'type': "investor",
                                          'alphabet': "I"
                                        });

//showing user his successrate and failure rate

                                        progressDialog.hide();
                                        showDialog(
                                            context: context,
                                            barrierDismissible: false,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: Center(
                                                    child: Text(
                                                        'Your Success Percentage')),
                                                content: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
                                                  children: <Widget>[
                                                    Container(
                                                      child: Text(
                                                        sucstring,
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: TextStyle(
                                                          color: color,
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          ElevatedButton(
                                                              onPressed: () {
                                                                Navigator.pushReplacement(
                                                                    context,
                                                                    MaterialPageRoute(
                                                                        builder:
                                                                            (context) =>
                                                                                DashboardI()));
                                                              },
                                                              child: Text(
                                                                  "Proceed"))
                                                        ])
                                                  ],
                                                ),
                                              );
                                            });
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
                                  },
                                  color: Color(0xff0095FF),
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(50),
                                  ),
                                  child: Text(
                                    "Register",
                                    style: TextStyle(
                                      fontWeight: FontWeight.w600,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 14,
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
