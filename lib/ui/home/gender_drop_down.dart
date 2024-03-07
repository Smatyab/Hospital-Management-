import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class GenderDropdownTextField extends StatefulWidget {
  const GenderDropdownTextField({Key? key}) : super(key: key);

  @override
  _GenderDropdownTextFieldState createState() =>
      _GenderDropdownTextFieldState();
}

class _GenderDropdownTextFieldState extends State<GenderDropdownTextField> {
  String selectedGender = 'Select Your Gender'; // Default selection

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          depth: 4,
          intensity: 0.5,
          lightSource: LightSource.topLeft,
        ),
        child: TextFormField(
          readOnly: true,
          onTap: _pickGenderDialog,
          controller: TextEditingController(text: selectedGender),
          decoration: InputDecoration(
            hintText: 'Select Your Gender',
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: InkWell(
              onTap: _pickGenderDialog,
              child: Padding(
                padding: const EdgeInsets.all(8),
                child: NeumorphicIcon(
                  Icons.male,
                  style: NeumorphicStyle(
                    color: Colors.grey,
                    depth: 4,
                    intensity: 0.5,
                    lightSource: LightSource.topLeft,
                  ),
                ),
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide.none,
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _pickGenderDialog() async {
    // You can show a gender selection dialog or navigate to another screen for selection.
    // For simplicity, I'll use a basic dialog for demonstration.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Select Gender'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                title: Text('Male'),
                onTap: () {
                  _updateSelectedGender('Male');
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                title: Text('Female'),
                onTap: () {
                  _updateSelectedGender('Female');
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _updateSelectedGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }
}
