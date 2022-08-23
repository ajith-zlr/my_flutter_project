// ignore_for_file: deprecated_member_use

import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:url_launcher/url_launcher.dart';

class chat extends StatefulWidget {
  const chat({Key? key}) : super(key: key);

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> {
  TextEditingController _numbercontroller = TextEditingController();
  TextEditingController _textController = TextEditingController();
  GlobalKey<ScaffoldState> _globalKey = GlobalKey<ScaffoldState>();

  String _selectedcountry = "+91";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       key: _globalKey,
      appBar: AppBar(
        title: Text("chat2x"),
      ),
      body: Container(
        margin: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(children: [
              Expanded(
                  flex: 50,
                  child: CountryCodePicker(
                    initialSelection: "IN",
                    favorite: ["+91", "IN"],
                    onChanged: (item) {
                      print("country code: ${item.dialCode}");
                      setState(() {
                        _selectedcountry = item.dialCode!;
                      });
                    },
                  )),
              Expanded(
                  flex: 80,
                  child: TextField(
                    controller: _numbercontroller,
                    keyboardType: TextInputType.number,
                    maxLength: 11,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: "enter your mobile number",
                      labelText: "mobile number",
                    ),
                  ))
            ]),
            Expanded(
              child: TextField(
                controller: _textController,
                minLines: 3,
                maxLines: 10000,
                keyboardType: TextInputType.number,
                maxLength: 50,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: "enter your message",
                  labelText: "Message",
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton(
                color: Colors.blue,
                textColor: Colors.black,
                onPressed: () {
                  sendmessage();
                },
                child: Text("send message")),
          ],
        ),
      ),
    );
  }

  void sendmessage() {
    String number, message;
    if (_numbercontroller.text == null || _numbercontroller.text.length < 10) {
      _globalKey.currentState!.showSnackBar(
        (SnackBar(
          content: Text("Enter valid number"),
        )),
      );
      return;
    } else
      number = _selectedcountry + _numbercontroller.text;
    message = _selectedcountry + _textController.text;
    String url = "https://wa.me/$number?text  =" + Uri.encodeComponent(message);
    launchURL(url);
  }

  launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
