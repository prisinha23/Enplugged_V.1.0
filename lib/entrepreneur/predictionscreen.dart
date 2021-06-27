import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'flask.dart';

class PridictionScreen extends StatefulWidget {
  PridictionScreen({Key key}) : super(key: key);

  @override
  _PridictionScreenState createState() => _PridictionScreenState();
}

class _PridictionScreenState extends State<PridictionScreen> {
  var result = "x";
  int modelreport;
  int famout = 0;
  int count = 30;
  int one = 1;
  int zero = 0;
  String value = "1";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          ElevatedButton(
              onPressed: () async {
                var url = Uri.parse(
                    'https://enpluggedmodel.herokuapp.com/?funding=$famout&Emp_count=19&N_advisor=$count&part_start=$zero&worked_top=$one&bothps=$zero&product=$one&service=$zero&part_suc_strt=$zero&bachelors=$zero&masters=$zero&nodegree=$one&phd=$zero');
                var response = await http.get(url);
                var reslut = response.body;
                print('Response status: ${response.statusCode}');
                print('Response body: ${response.body}');
                print(reslut);
                result = reslut.toString();
                print(result);
                value = result.substring(1, 2);
                modelreport = int.parse(value);
                print("Here is the report final:$modelreport");
                print(value);
              },
              child: Text("Enter")),
          Text(result)
        ],
      ),
    );
  }
}
