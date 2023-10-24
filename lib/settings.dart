import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final TextEditingController emailcontroller = TextEditingController();
  final TextEditingController passwordcontroller = TextEditingController();

//Createria that email mus follow
  bool isEmailValid(String email) {
    String emailPattern = r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)*(\.[a-z]{2,})$';
    RegExp regExp = RegExp(emailPattern);

    return regExp.hasMatch(email);
  }

  bool sPValid(String password) {
    // Check password length (at least 8 characters)
    if (password.length < 8) {
      return false;
    }
    RegExp upperCaseRegExp = RegExp(r'[A-Z]');
    RegExp lowerCaseRegExp = RegExp(r'[a-z]');
    RegExp digitRegExp = RegExp(r'[0-9]');

    if (!upperCaseRegExp.hasMatch(password) ||
        !lowerCaseRegExp.hasMatch(password) ||
        !digitRegExp.hasMatch(password)) {
      return false;
    }
    return true;
  }

  void showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Close'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        backgroundColor: Colors.lightBlue[800],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              child: Column(
                mainAxisAlignment:
                    MainAxisAlignment.center, // Center vertically
                crossAxisAlignment:
                    CrossAxisAlignment.center, // Center horizontally
                children: [
                  const Text(
                    'Account Settings',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                  ),
                  const SizedBox(height: 100),

                  // Change Name Button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      _showChangeNameDialog();
                    },
                    color: Colors.lightBlue[800],
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Text(
                      'Change Name',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Change Email button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      _showChangeEmailDialog();
                    },
                    color: Colors.lightBlue[800],
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Text(
                      'Change Email',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 50),

                  // Change Password Button
                  MaterialButton(
                    minWidth: double.infinity,
                    height: 60,
                    onPressed: () {
                      // TODO create dialog box to change password
                      _showChangePasswordDialog();
                    },
                    color: Colors.lightBlue[800],
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Colors.black,
                      ),
                      borderRadius: BorderRadius.circular(40),
                    ),
                    child: const Text(
                      'Change Password',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to show the "Change Name" dialog
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  void _showChangeNameDialog() {
    _firstNameController.clear();
    _lastNameController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Name'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _firstNameController,
                decoration: const InputDecoration(
                  labelText: 'First Name',
                ),
              ),
              TextField(
                controller: _lastNameController,
                decoration: const InputDecoration(
                  labelText: 'Last Name',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Handle cancel button press
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Handle confirm button press and update the name
                // TODO: Update the name in database
                // Close the dialog
                Navigator.of(context).pop();
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _confirmEmailController = TextEditingController();
  // Function to show the "Change Email" dialog box
  void _showChangeEmailDialog() {
    // clear out any previous input
    _emailController.clear();
    _confirmEmailController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Email'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                ),
              ),
              TextField(
                controller: _confirmEmailController,
                decoration: const InputDecoration(
                  labelText: 'Confirm Email',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Handle cancel button press
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String email = _emailController.text;
                //String confirmEmail = _confirmEmailController.text;
                if (!isEmailValid(email)) {
                  showErrorDialog(context, 'Please enter a valid email.');
                } else {
                  // Handle confirm button press and update the email
                  // TODO: Update the email in database
                  // Close the dialog
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }

  final TextEditingController _currentPWController = TextEditingController();
  final TextEditingController _newPWController = TextEditingController();
  final TextEditingController _confirmPWController = TextEditingController();
  // Function to show the "Change Password" dialog box
  void _showChangePasswordDialog() {
    // clear out any previous input
    _currentPWController.clear();
    _newPWController.clear();
    _confirmPWController.clear();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Change Password'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextField(
                obscureText: true,
                controller: _currentPWController,
                decoration: const InputDecoration(
                  labelText: 'Current Password',
                ),
              ),
              TextField(
                obscureText: true,
                controller: _newPWController,
                decoration: const InputDecoration(
                  labelText: 'New Password',
                ),
              ),
              TextField(
                obscureText: true,
                controller: _confirmPWController,
                decoration: const InputDecoration(
                  labelText: 'Confirm New Password',
                ),
              ),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                // Handle cancel button press
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newPassword = passwordcontroller.text;
                if (!sPValid(newPassword)) {
                  showErrorDialog(context, 'Please enter a valid password.');
                } else {
                  // Handle confirm button press and update the password
                  // TODO: Update the password in database
                  // Close the dialog
                  Navigator.of(context).pop();
                }
              },
              child: const Text('Confirm'),
            ),
          ],
        );
      },
    );
  }
}
