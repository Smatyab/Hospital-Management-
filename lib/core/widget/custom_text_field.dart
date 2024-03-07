import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class TextFieldDesign extends StatefulWidget {
  final String? hintText;
  final String? labelText;
  final Icon prefixIcon;
  final bool isObscure;
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final bool showPasswordIcon;

  const TextFieldDesign({
    Key? key,
    required this.hintText,
    this.labelText = "",
    required this.prefixIcon,
    required this.controller,
    this.isObscure = false,
    this.validator,
    this.showPasswordIcon = false,
  }) : super(key: key);

  @override
  _TextFieldDesignState createState() => _TextFieldDesignState();
}

class _TextFieldDesignState extends State<TextFieldDesign> {
  bool _isObscure = true;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: Neumorphic(
        style: NeumorphicStyle(
          shape: NeumorphicShape.flat,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(12)),
          depth: 4,
          intensity: 0.5,
          lightSource: LightSource.topLeft,
        ),
        child: TextFormField(
          controller: widget.controller,
          obscureText: widget.isObscure && _isObscure,
          validator: widget.validator,
          style: TextStyle(color: Colors.black),
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: TextStyle(color: Colors.grey),
            prefixIcon: widget.prefixIcon,
            suffixIcon: widget.showPasswordIcon
                ? IconButton(
                    icon: Icon(
                      _isObscure ? Icons.visibility_off : Icons.visibility,
                      color: Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _isObscure = !_isObscure;
                      });
                    },
                  )
                : null,
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
}
