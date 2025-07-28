import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:qr_scanner/ResultCard.dart';
import 'detectType.dart';

class QR extends StatefulWidget {
  const QR({super.key});

  @override
  State<QR> createState() => _QRState();
}

class _QRState extends State<QR> {
  bool _canScan = true;
  String type = "";
  bool torchStatus = false;
  String? result = "";
  final MobileScannerController controller = MobileScannerController(
    detectionSpeed: DetectionSpeed.unrestricted,
    detectionTimeoutMs: 3000,
    formats: [BarcodeFormat.qrCode],
    torchEnabled: false,
    autoStart: true,
    facing: CameraFacing.back,
  );

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0E0E25),
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'QR Scanner',
          style: TextStyle(
              fontFamily: 'GreatVibes', color: Colors.white, fontSize: 25),
        ),
        backgroundColor: Color(0xFF352B4D),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: SizedBox(
                height: MediaQuery.sizeOf(context).height * 0.5,
                width: MediaQuery.sizeOf(context).width,
                child: Stack(alignment: Alignment.topRight, children: [
                  MobileScanner(
                    controller: controller,
                    scanWindow: Rect.fromCenter(
                      center: Offset(MediaQuery.of(context).size.width / 2,
                          MediaQuery.of(context).size.height * 0.5 / 2),
                      width: 250,
                      height: 250,
                    ),
                    overlayBuilder: (context, constraints) {
                      return Center(
                        child: Container(
                          height: 250,
                          width: 250,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      );
                    },
                    fit: BoxFit.fill,
                    onDetectError: (result, error) {
                      setState(() {
                        result = "Error!";
                      });
                    },
                    onDetect: (capture) async {
                      if (!_canScan) return;

                      if (capture.barcodes.first.rawValue != null) {
                        setState(() {
                          _canScan = false;
                          result = capture.barcodes.first.rawValue ?? "unknown";
                          type = detectType(result!);
                        });

                        await Future.delayed(
                            Duration(milliseconds: 3000)); // cooldown
                        setState(() => _canScan = true);
                      }
                    },
                  ),
                  TextButton(
                    onPressed: () {
                      setState(() {
                        controller.toggleTorch();
                        torchStatus = !torchStatus;
                      });
                    },
                    child: Icon(torchStatus
                        ? Icons.flashlight_off
                        : Icons.flashlight_on),
                  ),
                ]),
              ),
            ),
          ),
          SizedBox(
            height: 40,
          ),
          ResultCard(canScan: _canScan, result: result, type: type),
        ],
      ),
    );
  }
}
