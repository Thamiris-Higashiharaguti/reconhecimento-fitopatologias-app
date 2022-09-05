import 'package:flutter/material.dart';

showAlertDialog(BuildContext context, title, message){ 
    showDialog<String>(
        context: context,
        builder: (BuildContext context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: <Widget>[
            TextButton(
            onPressed: () => Navigator.pop(context, 'OK'),
            child: const Text('OK'),
            ),
        ],
        ),
    );
}