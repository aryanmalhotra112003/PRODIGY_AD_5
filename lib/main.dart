import 'package:flutter/material.dart';
import 'package:qr_scanner/QR.dart';

void main() => runApp(Scanner());

class Scanner extends StatelessWidget {
  const Scanner({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: QR(),
    );
  }
}
