import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String name;
  final VoidCallback? onClicked;
  const ButtonWidget({Key? key, this.onClicked, required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onClicked,
      child: Text(
        name,
        style: const TextStyle(fontSize: 20),
      ),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
