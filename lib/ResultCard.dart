import 'package:flutter/material.dart';
import 'buildContentWidget.dart';

class ResultCard extends StatelessWidget {
  const ResultCard({
    super.key,
    required bool canScan,
    required this.result,
    required this.type,
  }) : _canScan = canScan;

  final bool _canScan;
  final String? result;
  final String type;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.sizeOf(context).height * 0.2,
      width: MediaQuery.sizeOf(context).width * 0.9,
      decoration: BoxDecoration(
          color: Color(0xFF4B2E5C), borderRadius: BorderRadius.circular(30)),
      child: Center(
        child: AnimatedSwitcher(
          duration: Duration(milliseconds: 300),
          transitionBuilder: (Widget child, Animation<double> animation) {
            return FadeTransition(
              opacity: animation,
              child: child,
            );
          },
          child: _canScan
              ? Text(
                  'Scanning...',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 35,
                      fontFamily: 'GreatVibes'),
                )
              : buildContentWidget(result!, type),
        ),
      ),
    );
  }
}
