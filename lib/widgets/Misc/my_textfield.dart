import 'package:flutter/material.dart';

// ignore: must_be_immutable
class MyTextfield extends StatefulWidget {
  final TextEditingController textController;
  final String? hintText;
  final bool? isAutoFocus;
  final bool? isObscureText;
  String? target;
  MyTextfield({
    super.key,
    required this.textController,
    this.hintText,
    this.isAutoFocus,
    this.isObscureText,
    this.target,
  });

  @override
  State<MyTextfield> createState() => _MyTextfieldState();
}

class _MyTextfieldState extends State<MyTextfield> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: widget.isAutoFocus ?? false,
      controller: widget.textController,
      style: const TextStyle(fontSize: 22),
      obscureText: widget.isObscureText ?? false,
      decoration: InputDecoration(
        labelText: widget.hintText,
        hintStyle: const TextStyle(fontSize: 22),
        border: OutlineInputBorder(
          borderSide: const BorderSide(width: 3),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
      onChanged: (value) {
        setState(() {
          widget.target ??= value;
        });
      },
    );
  }
}
