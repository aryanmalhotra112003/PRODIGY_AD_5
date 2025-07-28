import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Launch extends StatelessWidget {
  const Launch({
    super.key,
    required this.uri,
    required this.value,
    required this.c,
  });

  final Uri uri;
  final String value;
  final Color c;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        if (await canLaunchUrl(uri)) {
          await launchUrl(uri, mode: LaunchMode.externalApplication);
        }
      },
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Text(
          value,
          softWrap: false,
          style: TextStyle(
            fontFamily: 'GreatVibes',
            color: c,
            fontSize: 35,
          ),
        ),
      ),
    );
  }
}
