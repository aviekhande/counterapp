import 'package:flutter/material.dart';

class TextFormFieldInputs extends StatefulWidget {
  final TextEditingController textController;
  final String textHint;
  const TextFormFieldInputs(
      {super.key, required this.textController, required this.textHint});

  @override
  State<TextFormFieldInputs> createState() => _TextFormFieldInputsState();
}

class _TextFormFieldInputsState extends State<TextFormFieldInputs> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.textController,
      decoration: InputDecoration(
          hintText: widget.textHint,
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black))),
    );
  }
}
