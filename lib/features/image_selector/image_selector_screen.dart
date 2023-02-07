import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core/di/app_di.dart';
import 'package:noty_mobile/core/localization/localization.dart';
import 'package:noty_mobile/core_ui/src/theme/app_text_theme.dart';
import 'package:noty_mobile/core_ui/src/theme/app_theme.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_bottom_sheet_tile.dart';
import 'package:noty_mobile/core_ui/src/widgets/app_diviider.dart';
import 'package:noty_mobile/core_ui/src/widgets/modal_app_bar.dart';

import 'bloc/image_selector_bloc.dart';
import 'bloc/image_selector_event.dart';
import 'bloc/image_selector_state.dart';

class ImageSelectorScreen extends StatelessWidget {
  final Function onClose;

  const ImageSelectorScreen({
    required this.onClose,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            color: AppTheme.lightColor,
          ),
          child: BlocProvider<ImageSelectorBloc>(
            create: (BuildContext context) => ImageSelectorBloc(
              appRouter: appLocator.get<AppRouterDelegate>(),
            ),
            child: BlocBuilder<ImageSelectorBloc, ImageSelectorState>(
              builder: (BuildContext context, Object? state) {
                if (state is ImageSelectorContent) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 16,
                          right: 24,
                          top: 16,
                        ),
                        child: Column(
                          children: <Widget>[
                            AppBottomSheetTile(
                              text: 'Libreria Fotografica',
                              textStyle: AppTextTheme.poppins16Medium.copyWith(
                                color: const Color.fromRGBO(52, 120, 246, 1),
                              ),
                              onPressed: () {
                                BlocProvider.of<ImageSelectorBloc>(context).add(
                                  SelectGalleryImage(onClose: onClose),
                                );
                                Navigator.pop(context);

                              },
                            ),
                            const AppDivider(),
                            AppBottomSheetTile(
                              text: 'Camera',
                              textStyle: AppTextTheme.poppins16Medium.copyWith(
                                color: const Color.fromRGBO(52, 120, 246, 1),
                              ),
                              onPressed: () {
                                BlocProvider.of<ImageSelectorBloc>(context)
                                    .add(SelectCameraImage(onClose: onClose));
                                Navigator.pop(context);
                              },

                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return const SizedBox.shrink();
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
