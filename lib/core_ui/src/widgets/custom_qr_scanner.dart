import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class CustomQrScanner extends StatefulWidget {
  final double width;
  final Function(String) onScanDetected;

  const CustomQrScanner({
    required this.width,
    required this.onScanDetected,
    Key? key,
  }) : super(key: key);

  @override
  State<CustomQrScanner> createState() => _CustomQrScannerState();
}

class _CustomQrScannerState extends State<CustomQrScanner> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 6),
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(10),
      ),
      height: MediaQuery.of(context).size.width * 0.65,
      width: MediaQuery.of(context).size.width * 0.65,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8),
        child: QRView(
          key: qrKey,
          overlay: QrScannerOverlayShape(
            overlayColor: Colors.transparent,
            cutOutSize: MediaQuery.of(context).size.width * 0.65,
          ),
          onQRViewCreated: onQRViewCreated,
        ),
      ),
    );
  }

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((event) {
      if (event.code != null) {
        widget.onScanDetected(event.code!);
      }
    });
  }
}
