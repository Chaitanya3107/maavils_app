import 'package:flutter/material.dart';
import 'package:maavils_app/home/home.dart';
import 'package:maavils_app/login/phone.dart';
import 'package:maavils_app/models/user.dart';
import 'package:maavils_app/services/auth.dart';
import 'package:pinput/pinput.dart';

class MyOtp extends StatefulWidget {
  const MyOtp({super.key});

  @override
  State<MyOtp> createState() => _MyOtpState();
}

final AuthService _auth = AuthService();

class _MyOtpState extends State<MyOtp> {
  // final FirebaseAuth _auth = FirebaseAuth.instance;
  final TextEditingController _otpController = TextEditingController();
  bool _isSendingOTP = false;

  void _verifyOTP(String otp) async {
    setState(() {
      _isSendingOTP = true;
    });
    UserObj? user = await _auth.verifyOTP(MyPhone.verificationId, otp);
    setState(() {
      _isSendingOTP = false;
    });
    if (user != null) {
      // OTP verified, navigate to home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const MyHome()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    final defaultPinTheme = PinTheme(
      width: 50,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 20,
        color: Colors.black,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: const Color.fromARGB(20, 158, 158, 158),
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(18),
      ),
    );

    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(
          screenWidth * 0.06,
          screenWidth * 0.15,
          screenWidth * 0.06,
          screenWidth * 0.00,
        ),
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Pinput(
              length: 6,
              controller: _otpController,
              defaultPinTheme: defaultPinTheme,
              showCursor: true,
            ),
            const SizedBox(height: 20),
            _isSendingOTP
                ? const CircularProgressIndicator(
                    color: Colors.black,
                  )
                : SizedBox(
                    height: 45,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        _verifyOTP(_otpController.text);
                        // Navigator.pushReplacement(
                        //     context,
                        //     MaterialPageRoute(
                        //         builder: (context) => const MyHome()));
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                      child: const Text(
                        'Verify',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
            TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const MyPhone()),
                    (route) => false,
                  );
                },
                child: const Text(
                  "Edit phone number?",
                  style: TextStyle(color: Colors.black, fontSize: 15),
                ))
          ],
        ),
      ),
    );
  }
}
