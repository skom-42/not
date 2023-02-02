import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/light_button.dart';
import 'package:noty_mobile/core_ui/src/widgets/page_app_bar.dart';
import 'package:noty_mobile/data/repositories/chats_repository.dart';
import 'package:noty_mobile/domain/models/chat_list_item_model.dart';
import 'package:noty_mobile/features/dialog_screen/ui/dialog_page.dart';
import 'package:noty_mobile/features/home/scan/bloc/scan_bloc.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanScreen extends StatefulWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  State<ScanScreen> createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  final qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;
  bool isLightOn = false;
  String? plate;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    // if (Platform.isAndroid) {
    //   await controller!.pauseCamera();
    // }
    controller!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<ScanBloc>(
      create: (BuildContext context) => ScanBloc(
        appRouter: appLocator<AppRouterDelegate>(),
      ),
      child: BlocBuilder<ScanBloc, ScanState>(
        builder: (BuildContext context, ScanState state) {
          if (state is ContentState) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  PageAppBar(
                    title: '',
                    onLeadingPressed: () {},
                    isNeedLeadingIcon: false,
                  ),
                  Expanded(
                    flex: 3,
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: Text(
                        AppLocalizations.of(context).value('Scan QR'),
                        style: AppTextTheme.poppins30SemiBold.copyWith(
                          color: AppTheme.lightColor,
                        ),
                      ),
                    ),
                  ),
                  Container(
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
                  ),
                  const Spacer(),
                  LightButton(
                    isLightOn: isLightOn,
                    onToggleSwitch: () async {
                      setState(() {
                        isLightOn = !isLightOn;
                      });

                      await controller?.toggleFlash();
                    },
                  ),
                  const SizedBox(height: 90)
                ],
              ),
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  void onQRViewCreated(QRViewController c) {
    setState(() {
      controller = c;

      controller!.resumeCamera();
    });
    controller?.scannedDataStream.listen((event) {
      print('%scannedDataStream% ${event.code}');
      if (event.code != null && plate == null) {
        plate = event.code;
        Future(
          () async {
            final ChatListItemModel? chat =
                await appLocator<ChatRepository>().getChat(plate: event.code!);
            if (chat != null) {
              appLocator<AppRouterDelegate>().push(DialogPage(chatModel: chat));
            }
          },
        );
      }
    });
  }
}
