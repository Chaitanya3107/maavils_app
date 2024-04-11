import 'package:flutter/material.dart';
import 'package:maavils_app/authenticate/authenticate.dart';
import 'package:maavils_app/models/user.dart';
import 'package:maavils_app/navigation/navigation.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    // us accessing user data from the provider to transfer them to different screen

    final user = Provider.of<UserObj?>(context);

    if (user == null) {
      return const Authenticate();
    } else {
      return const Navigation();
    }

    // return FigmaToCodeApp();
  }
}
