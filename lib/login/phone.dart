import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:maavils_app/login/myotp.dart';
import 'package:maavils_app/services/auth.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({super.key});

  static String verificationId = '';

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

final AuthService _auth = AuthService();

class _MyPhoneState extends State<MyPhone> {
  final TextEditingController _countryCodeController =
      TextEditingController(text: "+91");
  final TextEditingController _phoneNumberController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        margin: EdgeInsets.all(screenWidth * 0.06),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(
                screenWidth * 0.02,
                screenWidth * 0.00,
                screenWidth * 0.00,
                screenWidth * 0.02,
              ),
              alignment: Alignment.centerLeft,
              child: const Text(
                'Phone Verification',
                style: TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
              ),
            ),
            Container(
              margin: EdgeInsets.fromLTRB(
                screenWidth * 0.00,
                screenWidth * 0.00,
                screenWidth * 0.00,
                screenWidth * 0.04,
              ),
              decoration: BoxDecoration(
                border: Border.all(width: 1, color: Colors.grey),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 10),
                  SizedBox(
                    width: 40,
                    child: TextField(
                      controller: _countryCodeController,
                      decoration:
                          const InputDecoration(border: InputBorder.none),
                    ),
                  ),
                  const Text(
                    '|',
                    style: TextStyle(fontSize: 32, color: Colors.grey),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: "Phone",
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: 45,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (_phoneNumberController.text.isEmpty) {
                    Fluttertoast.showToast(
                      msg: "Please enter a phone number",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  } else if (_phoneNumberController.text.length != 10) {
                    Fluttertoast.showToast(
                      msg: "Please enter a valid number",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.BOTTOM,
                    );
                  } else {
                    await _auth.signInPhone(
                        _countryCodeController, _phoneNumberController);
                    // Only navigate if the phone number is not empty
                    // Navigate to MyOtp page
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => const MyOtp()));
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                child: const Text(
                  'Send OTP',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
