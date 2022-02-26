import 'dart:async';
import 'package:flutter/material.dart';

class LoadingButton extends StatefulWidget {
  final String description;
  final FutureOr Function() onPressed;
  const LoadingButton({Key? key, required this.description, required this.onPressed}) : super(key: key);

  @override
  State<LoadingButton> createState() => _LoadingButtonState();
}

class _LoadingButtonState extends State<LoadingButton> {
  bool isLoading = false;

  void changeState() async {
    setState(() {
      isLoading = true;
    });
    await widget.onPressed();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 600),
      height: 60,
      width: isLoading ? 80 : 140,
      child: ElevatedButton(
        style: ButtonStyle(backgroundColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.disabled)) {
            return Theme.of(context).primaryColor;
          }
          return Theme.of(context).primaryColor;
        })),
        onPressed: isLoading ? () {} : changeState,
        child: Visibility(
          visible: isLoading,
          child: const CircularProgressIndicator(color: Colors.white),
          replacement: Text(widget.description),
        ),
      ),
    );
  }
}
