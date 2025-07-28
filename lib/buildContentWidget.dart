import 'package:flutter/material.dart';
import 'package:qr_scanner/Launch.dart';

Widget buildContentWidget(String value, String type) {
  switch (type) {
    case 'url':
      final uri = value.startsWith('http')
          ? Uri.parse(value)
          : Uri.parse('https://$value');
      return Launch(
        uri: uri,
        value: value,
        c: Colors.indigoAccent,
      );

    case 'email':
      final uri = Uri(scheme: 'mailto', path: value);
      return Launch(
        uri: uri,
        value: value,
        c: Colors.blue,
      );

    case 'number':
      final uri = Uri(scheme: 'tel', path: value);
      return Launch(
        uri: uri,
        value: value,
        c: Colors.pink,
      );

    case 'upi':
      final uri = Uri.parse(value);
      return Launch(
        uri: uri,
        value: value,
        c: Colors.green,
      );

    case 'text':
    default:
      return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          value,
          softWrap: false,
          style: TextStyle(
            fontFamily: 'GreatVibes',
            fontSize: 35,
            color: Colors.white,
          ),
        ),
      );
  }
}
