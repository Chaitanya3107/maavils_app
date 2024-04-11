import 'package:flutter/material.dart';
import 'package:maavils_app/profile/userProfile.dart';

class UserProfileProvider extends ChangeNotifier {
  late UserProfile _userProfile;

  UserProfile get userProfile => _userProfile;

  UserProfileProvider() {
    _userProfile = UserProfile(
      name: 'ABC',
      email: 'abc@gmail.com',
      phoneNumber: '1234567891',
    );
  }

  void updateName(String newName) {
    _userProfile.name = newName;
    notifyListeners();
  }

  void updateEmail(String newEmail) {
    _userProfile.email = newEmail;
    notifyListeners();
  }

  void updatePhoneNumber(String newPhoneNumber) {
    _userProfile.phoneNumber = newPhoneNumber;
    notifyListeners();
  }
}
