import 'package:flutter/material.dart';
import 'package:maavils_app/profile/profileContent.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          '  Profile',
          style: TextStyle(
            fontSize: screenWidth * 0.07,
            fontWeight: FontWeight.w500,
            color: const Color.fromARGB(255, 0, 0, 0),
          ),
        ),
      ),
      backgroundColor: Colors.transparent,
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(screenWidth * 0.05,
                      screenWidth * 0.34, screenWidth * 0.05, 0),
                  child: SizedBox(
                    width: double.infinity,
                    height: screenHeight * 0.65,
                    child: const ProfiileContent(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
