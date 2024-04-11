import 'package:flutter/material.dart';
import 'package:maavils_app/profile/profileState.dart';
import 'package:maavils_app/services/auth.dart';
import 'package:provider/provider.dart';

AuthService _auth = AuthService();

class ProfiileContent extends StatelessWidget {
  const ProfiileContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.fromLTRB(screenWidth * 0.01, screenWidth * 0.05, 0, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ProfileItem(
              icon: Icons.person,
              label: 'Name',
              value: context.watch<UserProfileProvider>().userProfile.name,
              onPressed: () {},
            ),
            SizedBox(height: screenWidth * 0.1),
            ProfileItem(
              icon: Icons.email,
              label: 'Email',
              value: context.watch<UserProfileProvider>().userProfile.email,
              onPressed: () {},
            ),
            SizedBox(height: screenWidth * 0.1),
            ProfileItem(
              icon: Icons.phone,
              label: 'Phone Number',
              value:
                  context.watch<UserProfileProvider>().userProfile.phoneNumber,
              onPressed: () {},
            ),
            SizedBox(height: screenWidth * 0.1),
            ElevatedButton(
              onPressed: () async {
                await _auth.signOut();
              },
              child: const Text(
                "Logout",
                style: TextStyle(
                  backgroundColor: Colors.transparent,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class ProfileItem extends StatefulWidget {
  final IconData icon;
  final String label;
  String value;
  final VoidCallback? onPressed;

  ProfileItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
    this.onPressed,
  });

  @override
  State<ProfileItem> createState() => _ProfileItemState();
}

class _ProfileItemState extends State<ProfileItem> {
  late TextEditingController _textEditingController;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(text: widget.value);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final profileProvider = Provider.of<UserProfileProvider>(context);

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(screenWidth * 0.06),
        border: Border.all(
          color: Colors.blue,
          width: screenWidth * 0.003,
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(screenWidth * 0.06),
        child: Material(
          color: Colors.white,
          child: ListTile(
            onTap: () {
              if (widget.onPressed != null) {
                widget.onPressed!();
              }
            },
            leading: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(screenWidth * 0.06),
                color: Colors.white,
              ),
              child: Icon(widget.icon, color: Colors.blue),
            ),
            title: Text(
              widget.value,
              style: const TextStyle(
                backgroundColor: Colors.transparent,
                color: Colors.blue,
                fontWeight: FontWeight.w500,
                fontSize: 20,
              ),
            ),
            trailing: IconButton(
              onPressed: () {
                if (widget.onPressed != null) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Edit ${widget.label}'),
                        content: TextField(
                          controller: _textEditingController,
                          onChanged: (newValue) {
                            // No need to update UI here
                          },
                          decoration: InputDecoration(
                            hintText: 'Enter new ${widget.label}',
                          ),
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Text('Cancel'),
                          ),
                          TextButton(
                            onPressed: () {
                              // Update the profile information
                              switch (widget.label) {
                                case 'Name':
                                  profileProvider
                                      .updateName(_textEditingController.text);
                                  break;
                                case 'Email':
                                  profileProvider
                                      .updateEmail(_textEditingController.text);
                                  break;
                                case 'Phone Number':
                                  profileProvider.updatePhoneNumber(
                                      _textEditingController.text);
                                  break;
                              }
                              // Update the value in the widget
                              setState(() {
                                widget.value = _textEditingController.text;
                              });
                              Navigator.of(context).pop();
                            },
                            child: const Text('Save'),
                          ),
                        ],
                      );
                    },
                  );
                }
              },
              icon: const Icon(Icons.edit),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
