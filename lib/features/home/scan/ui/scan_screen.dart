import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/custom_qr_scanner.dart';
import 'package:noty_mobile/core_ui/src/widgets/light_button.dart';
import 'package:noty_mobile/core_ui/src/widgets/page_app_bar.dart';
import 'package:noty_mobile/features/home/scan/bloc/scan_bloc.dart';

class ScanScreen extends StatelessWidget {
  const ScanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width - 130;
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
                  CustomQrScanner(
                    width: screenWidth,
                    onScanDetected: (String result) {},
                  ),
                  const Spacer(),
                  const LightButton(),
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
}
