import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AuthMainButton extends StatelessWidget {
  final String mainButtonLabel;
  final Function() onPressed;
  const AuthMainButton({
    Key? key, required this.mainButtonLabel,required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 30),
      child: Material(
        color: Colors.purple,
        borderRadius: BorderRadius.circular(25),
        child: MaterialButton(
          minWidth: double.infinity,
          onPressed: onPressed,
          child: Text(
            mainButtonLabel,
            style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white),
          ),
        ),
      ),
    );
  }
}

class HaveAccount extends StatelessWidget {
  final String haveAccount;
  final String actionLabel;
  final Function() onPressed;

  const HaveAccount({
    Key? key,required this.actionLabel,required this.haveAccount,required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          haveAccount,
          style:const TextStyle(fontSize: 16, fontStyle: FontStyle.italic),
        ),
        TextButton(
            onPressed: onPressed,
            child: Text(
              actionLabel,
              style:const TextStyle(
                  color: Colors.purple,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ))
      ],
    );
  }
}

class AuthHeaderLabel extends StatelessWidget {
  final String headerLabel;
  const AuthHeaderLabel({
    Key? key, required this.headerLabel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            headerLabel,
            style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          ),
          IconButton(
              onPressed: () {
                Navigator.pushReplacementNamed(context, '/Welcome_screen');
              },
              icon: const Icon(
                Icons.home_work,
                size: 40,
              ))
        ],
      ),
    );
  }
}

var TextFormDecoration=InputDecoration(
  labelText: 'Full Name',
  hintText: 'Enter Your Full Name',
  border: OutlineInputBorder(
    borderRadius: BorderRadius.circular(25),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Colors.purple, width: 1),
    borderRadius: BorderRadius.circular(25),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide:
    BorderSide(color: Colors.deepPurpleAccent, width: 2),
    borderRadius: BorderRadius.circular(25),
  ),
);
