import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hophseeflutter/core/widget/custome_app_bar.dart';

class SettingsPage extends StatefulWidget {
  static const route = '/setting_screen';
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _darkModeEnabled = false;
  bool _showEmailNotifications = true;
  bool _enableBiometrics = false;
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.only(top: 20.h),
              child: CustomAppbar2(
                label: 'Settings',
              ),
            ),
          ),
          SingleChildScrollView(
            padding: EdgeInsets.only(left: 15.w, right: 15.w, top: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildCategoryHeader('General Settings'),
                _buildSettingItem('Notifications', _notificationsEnabled,
                    (value) {
                  setState(() {
                    _notificationsEnabled = value!;
                  });
                }),
                _buildSettingItem('Dark Mode', _darkModeEnabled, (value) {
                  setState(() {
                    _darkModeEnabled = value!;
                  });
                }),
                _buildSettingItem(
                    'Email Notifications', _showEmailNotifications, (value) {
                  setState(() {
                    _showEmailNotifications = value!;
                  });
                }),
                _buildSettingItem('Biometric Authentication', _enableBiometrics,
                    (value) {
                  setState(() {
                    _enableBiometrics = value!;
                  });
                }),
                SizedBox(height: 24),
                _buildCategoryHeader('Language Settings'),
                _buildLanguageDropdown(),
                SizedBox(height: 24),
                _buildCategoryHeader('Account Settings'),
                _buildSettingItem('Change Password', null, (_) {
                  // Add functionality for changing password
                }),
                _buildSettingItem('Log Out', null, (_) {
                  // Add functionality for logging out
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: Color(0xFF00BFA5), // Teal
        ),
      ),
    );
  }

  Widget _buildSettingItem(
      String title, bool? value, ValueChanged<bool?> onChanged) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: value != null
            ? Switch(
                value: value,
                onChanged: onChanged,
                activeColor: Color(0xFF00BFA5), // Teal
              )
            : Icon(Icons.arrow_forward_ios, size: 20, color: Color(0xFF00BFA5)),
      ),
    );
  }

  Widget _buildLanguageDropdown() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.4),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      margin: EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        title: Text(
          'Language',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        ),
        trailing: DropdownButton<String>(
          value: _selectedLanguage,
          icon: Icon(Icons.arrow_drop_down),
          onChanged: (String? newValue) {
            setState(() {
              _selectedLanguage = newValue!;
            });
          },
          items: <String>['English', 'Spanish', 'French', 'German']
              .map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );
  }
}

/*class SettingsPage extends StatelessWidget {
  static const route = '/setting_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.only(top: 20),
        color: Colors.grey[200], // Custom background color
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomAppbar2(label: 'Settings'),
            Container(
              padding: EdgeInsets.only(left: 15.h, right: 15.h, top: 15.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle('General Settings'),
                  _buildSwitchTile('Notifications', true),
                  _buildSwitchTile('Dark Mode', false),
                  SizedBox(height: 24),
                  _buildSectionTitle('Account Settings'),
                  _buildListTile('Change Password', Icons.lock, () {
                    // Handle navigation to change password screen
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget _buildSwitchTile(String title, bool value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        trailing: Switch(
          value: value,
          onChanged: (value) {
            // Handle switch state change
          },
          activeColor: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Icon(
          icon,
          color: Colors.deepPurple,
        ),
        trailing: Icon(
          Icons.arrow_forward_ios,
          color: Colors.deepPurple,
        ),
        onTap: onTap,
      ),
    );
  }
}*/
