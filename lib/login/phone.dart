// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:maavils_app/login/myotp.dart';

// class MyPhone extends StatefulWidget {
//   const MyPhone({super.key});
//   static String verify = '';

//   @override
//   State<MyPhone> createState() => _MyPhoneState();
// }

// class _MyPhoneState extends State<MyPhone> {
//   TextEditingController countrycode = TextEditingController();
//   String phone = '';
//   @override
//   void initState() {
//     countrycode.text = "+91";
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: Container(
//         margin: EdgeInsets.all(screenWidth * 0.06),
//         alignment: Alignment.center,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               margin: EdgeInsets.fromLTRB(screenWidth * 0.02,
//                   screenWidth * 0.00, screenWidth * 0.00, screenWidth * 0.02),
//               alignment: Alignment.centerLeft,
//               child: const Text(
//                 'Phone Verification',
//                 style: TextStyle(fontWeight: FontWeight.w500),
//               ),
//             ),
//             Container(
//               margin: EdgeInsets.fromLTRB(screenWidth * 0.00,
//                   screenWidth * 0.00, screenWidth * 0.00, screenWidth * 0.04),
//               decoration: BoxDecoration(
//                   border: Border.all(width: 1, color: Colors.grey),
//                   borderRadius: BorderRadius.circular(20)),
//               child: Row(
//                 children: [
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   SizedBox(
//                     width: 40,
//                     child: TextField(
//                       controller: countrycode,
//                       decoration:
//                           const InputDecoration(border: InputBorder.none),
//                     ),
//                   ),
//                   const Text(
//                     '|',
//                     style: TextStyle(fontSize: 32, color: Colors.grey),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: TextField(
//                       onChanged: (value) {
//                         phone = value;
//                       },
//                       keyboardType: TextInputType.phone,
//                       decoration: const InputDecoration(
//                         border: InputBorder.none,
//                         hintText: "Phone",
//                       ),
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             SizedBox(
//               height: 45,
//               width: double.infinity,
//               child: ElevatedButton(
//                 onPressed: () async {
//                   await FirebaseAuth.instance.verifyPhoneNumber(
//                     phoneNumber: countrycode.text + phone,
//                     verificationCompleted: (PhoneAuthCredential credential) {},
//                     verificationFailed: (FirebaseAuthException e) {},
//                     codeSent: (String verificationId, int? resendToken) {
//                       MyPhone.verify = verificationId;
//                     },
//                     codeAutoRetrievalTimeout: (String verificationId) {},
//                   );
//                   Navigator.pushReplacement(context,
//                       MaterialPageRoute(builder: (context) => const MyOtp()));
//                 },
//                 style: ElevatedButton.styleFrom(
//                     backgroundColor: Colors.blue,
//                     shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(20))),
//                 child: const Text(
//                   'Send OTP',
//                   style: TextStyle(color: Colors.white),
//                 ),
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:maavils_app/login/myotp.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);

  static String verificationId = '';

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

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
                style: TextStyle(fontWeight: FontWeight.w500),
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
                  await FirebaseAuth.instance.verifyPhoneNumber(
                    phoneNumber: _countryCodeController.text +
                        _phoneNumberController.text,
                    verificationCompleted: (PhoneAuthCredential credential) {},
                    verificationFailed: (FirebaseAuthException e) {},
                    codeSent: (String verificationId, int? resendToken) {
                      MyPhone.verificationId = verificationId;
                    },
                    codeAutoRetrievalTimeout: (String verificationId) {},
                  );
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => const MyOtp()));
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
