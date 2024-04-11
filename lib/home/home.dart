import 'package:flutter/material.dart';
import 'package:maavils_app/services/auth.dart';

class MyHome extends StatefulWidget {
  const MyHome({super.key});

  @override
  State<MyHome> createState() => _MyHomeState();
}

AuthService _auth = AuthService();

class _MyHomeState extends State<MyHome> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          '  Chat with Councellor',
          style: TextStyle(
            fontSize: screenWidth * 0.06,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      body: Container(
        alignment: Alignment.center,
        child: ElevatedButton(
          child: const Text(
            "Logout",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
          onPressed: () async {
            ;
            await _auth.signOut();
          },
        ),
      ),
    );
  }
}
