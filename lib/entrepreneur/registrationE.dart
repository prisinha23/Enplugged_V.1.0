import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:enplugged/entrepreneur/dashboardE.dart';
import 'package:enplugged/entrepreneur/flask.dart';
import 'package:enplugged/entrepreneur/predictionscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:http/http.dart' as http;

class RegistrationEntrepreneur extends StatefulWidget {
  RegistrationEntrepreneur({Key key}) : super(key: key);

  @override
  _RegistrationEntrepreneurState createState() =>
      _RegistrationEntrepreneurState();
}

class _RegistrationEntrepreneurState extends State<RegistrationEntrepreneur> {
  final _formkey = GlobalKey<FormState>();
  ProgressDialog progressDialog;

  var result = "x";
  int modelreport;
  int famout = 0;
  int count = 30;
  int one = 1;
  int zero = 0;
  String value = "1";

  String valueChoose;
  String valueKind;
  String status;
  String valueyesno;
  String valueyesno2;
  String startsucc;
  String edu;

  String name = "x",
      ideaofstartup = "x",
      areaofwork = "x",
      ageofcompany = "x",
      educationqualification = "x",
      kindofstartup = "x";
  int fundingamount = 0,
      totalemployee = 0,
      waspartofstartup = 0,
      numberofadvisor = 0,
      topcompanies = 0,
      wassucessful = 0;

  int bachelor = 0, master = 0, phd = 0, nodegree = 0;
  int product = 0, service = 0, both = 0;
  List listItem = [
    "Select your Profession",
    "Profession as Entreprenuer",
    "Profession as Investor",
    "Profession as Guide"
  ];
  List education = ["Bachelor Degree", "Master's Degree", "Phd"];
  List yesno = [
    "YES",
    "NO",
  ];
  List kind = ["Product Based", "Service Based", "Both"];

  @override
  Widget build(BuildContext context) {
    progressDialog = ProgressDialog(context, type: ProgressDialogType.Normal);
    progressDialog.style(message: "Loading Your Data");

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
                    "Welcome Entrepreneur..",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Register Your Company For Better Result",
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
                              height: 20,
                            ),
                            Text(
                              "For The Founder",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            LinearProgressIndicator(
                              backgroundColor: Colors.blue,
                              valueColor: new AlwaysStoppedAnimation<Color>(
                                  Colors.white),
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
                                name = value;
                              },
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: 'StartUp Name',
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
                              maxLines: 3,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Fill this Section';
                                }
                                return null;
                              },
                              onChanged: (value) {
                                ideaofstartup = value;
                              },
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: "Idea Of StartUp",
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
                                areaofwork = value;
                              },
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: 'Area Of Work',
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
                                }
                                return null;
                              },
                              onChanged: (value) {
                                fundingamount = int.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: 'Enter Funding Amount',
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
                                          "Kind Of StartUp",
                                        ),
                                        dropdownColor: Colors.white,
                                        value: valueKind,
                                        onChanged: (newValue) {
                                          setState(() {
                                            valueKind = newValue;
                                            kindofstartup = valueKind;
                                            if (valueKind == "Product Based") {
                                              product = 1;
                                              service = 0;
                                              both = 0;
                                            } else if (valueKind ==
                                                "Service Based") {
                                              product = 0;
                                              service = 1;
                                              both = 0;
                                            } else {
                                              product = 0;
                                              service = 0;
                                              both = 1;
                                            }
                                          });
                                        },
                                        items: kind.map((valueItem) {
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
                                ageofcompany = value;
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: "Year Of Establishment",
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
                                totalemployee = int.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: 'Total Number Of Employee',
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
                                          "Was Part of Startup",
                                        ),
                                        dropdownColor: Colors.white,
                                        value: valueyesno,
                                        onChanged: (newValue) {
                                          setState(() {
                                            valueyesno = newValue;
                                            if (valueyesno == "YES") {
                                              waspartofstartup = 1;
                                            } else {
                                              waspartofstartup = 0;
                                            }
                                          });
                                        },
                                        items: yesno.map((valueItem) {
                                          return DropdownMenuItem(
                                              value: valueItem,
                                              child: Center(
                                                child: Text(
                                                  valueItem +
                                                      " Part Of StartUp",
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
                              height: 14,
                            ),
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
                                          "Was Startup successfull",
                                        ),
                                        dropdownColor: Colors.white,
                                        value: startsucc,
                                        onChanged: (newValue) {
                                          setState(() {
                                            startsucc = newValue;
                                            if (startsucc == "YES") {
                                              wassucessful = 1;
                                            } else {
                                              wassucessful = 0;
                                            }
                                          });
                                        },
                                        items: yesno.map((valueItem) {
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
                                numberofadvisor = int.parse(value);
                              },
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  fontSize: 19,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold),
                              decoration: InputDecoration(
                                  labelText: 'Total Number Advisors',
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
                                          "Worked in Top Companies",
                                        ),
                                        dropdownColor: Colors.white,
                                        value: valueyesno2,
                                        onChanged: (newValue) {
                                          setState(() {
                                            valueyesno2 = newValue;
                                            if (valueyesno2 == "YES") {
                                              topcompanies = 1;
                                            } else {
                                              topcompanies = 0;
                                            }
                                          });
                                        },
                                        items: yesno.map((valueItem) {
                                          return DropdownMenuItem(
                                              value: valueItem,
                                              child: Center(
                                                child: Text(
                                                  valueItem +
                                                      " Worked with Top Company",
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
                              height: 14,
                            ),
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
                                          "Educational Qualification",
                                        ),
                                        dropdownColor: Colors.white,
                                        value: edu,
                                        onChanged: (newValue) {
                                          setState(() {
                                            edu = newValue;
                                            educationqualification = edu;
                                            if (edu == "Bachelor Degree") {
                                              bachelor = 1;
                                              master = 0;
                                              phd = 0;
                                              nodegree = 0;
                                            } else if (edu ==
                                                "Master's Degree") {
                                              bachelor = 0;
                                              master = 1;
                                              phd = 0;
                                              nodegree = 0;
                                            } else if (edu == "Phd") {
                                              bachelor = 0;
                                              master = 0;
                                              nodegree = 0;
                                              phd = 1;
                                            } else {
                                              bachelor = 0;
                                              master = 0;
                                              phd = 0;
                                              nodegree = 1;
                                            }
                                          });
                                        },
                                        items: education.map((valueItem) {
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
                                                "Pridicting Data \n Detecting Your Success Aspect");

                                        print(
                                            "$fundingamount + $product + $service + $both + $totalemployee + $waspartofstartup + $wassucessful + $numberofadvisor + $topcompanies + $bachelor + $master + $phd + $nodegree");

//model pridiction is done here using flask api built by kunal,priyesh and pratik from sit/ise department....
                                        print(
                                            "Pridicting Your Model data successfull");
                                        progressDialog.update(
                                            message:
                                                "Predicting Your \n Success or Failure Aspect");

                                        var url = Uri.parse(
                                            'https://enpluggedmodel.herokuapp.com/?funding=$fundingamount&Emp_count=$totalemployee&N_advisor=$numberofadvisor&part_start=$waspartofstartup&worked_top=$topcompanies&bothps=$both&product=$product&service=$service&part_suc_strt=$wassucessful&bachelors=$bachelor&masters=$master&nodegree=$nodegree&phd=$phd');
                                        var response = await http.get(url);
                                        var reslut = response.body;
                                        print(
                                            'Response status: ${response.statusCode}');
                                        print(
                                            'Response body: ${response.body}');
                                        print(reslut);
                                        result = reslut.toString();
                                        print(result);
                                        value = result.substring(1, 2);
                                        modelreport = int.parse(value);
                                        int successmodel, failmodel;
                                        if (modelreport == 1) {
                                          successmodel = 1;
                                          failmodel = 0;
                                        } else {
                                          successmodel = 0;
                                          failmodel = 1;
                                        }
                                        print(
                                            "Here is the report final:$modelreport");
                                        print(value);

                                        ///model calling end here...
                                        ///
                                        ///
                                        progressDialog.update(
                                            message:
                                                "Finalizing The Data and Model...");
                                        await FirebaseFirestore.instance
                                            .collection("entrepreneur")
                                            .doc(email)
                                            .collection('details')
                                            .doc(email)
                                            .set({
                                          'name': name,
                                          'about': ideaofstartup,
                                          'areaofwork': areaofwork,
                                          'fundingamount': fundingamount,
                                          'kindofstartup': kindofstartup,
                                          'experienceinyear': ageofcompany,
                                          'totalnoofemployee': totalemployee,
                                          'waspartofstartup': waspartofstartup,
                                          'wasstartupsuccess': wassucessful,
                                          'totalnoofadvisor': numberofadvisor,
                                          'workedwithtopcompanies':
                                              topcompanies,
                                          'educationalqualification':
                                              educationqualification,
                                          'email': email,
                                          'type': "entrepreneur",
                                          'successpercentage': successmodel,
                                          'failpercentage': failmodel,
                                          'alphabet': "E"
                                        });
                                        progressDialog.update(
                                            message:
                                                "Updating Your \n Success or Failure Aspect");

                                        progressDialog.update(
                                            message: "And Finalizing..");

                                        await FirebaseFirestore.instance
                                            .collection("entrepreneurAll")
                                            .doc(email)
                                            .set({
                                          'name': name,
                                          'about': ideaofstartup,
                                          'areaofwork': areaofwork,
                                          'fundingamount': fundingamount,
                                          'kindofstartup': kindofstartup,
                                          'experienceinyear': ageofcompany,
                                          'totalnoofemployee': totalemployee,
                                          'waspartofstartup': waspartofstartup,
                                          'wasstartupsuccess': wassucessful,
                                          'totalnoofadvisor': numberofadvisor,
                                          'workedwithtopcompanies':
                                              topcompanies,
                                          'educationalqualification':
                                              educationqualification,
                                          'email': email,
                                          'type': "entrepreneur",
                                          'successpercentage':
                                              successmodel.toString(),
                                          'failpercentage':
                                              failmodel.toString(),
                                          'alphabet': "E"
                                        });
                                        Color color;
                                        if (successmodel > failmodel) {
                                          color = Colors.green;
                                        } else {
                                          color = Colors.red;
                                        }
                                        var fin = successmodel;
                                        String report;
                                        if (fin == 1) {
                                          report = "Chance of Success High";
                                        } else {
                                          report = "Low Chance of Success";
                                        }
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
                                                        report.toString(),
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
                                                                                DashboardE()));
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
