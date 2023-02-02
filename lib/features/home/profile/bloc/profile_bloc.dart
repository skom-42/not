import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:navigation/navigation.dart';
import 'package:noty_mobile/core_ui/src/theme/app_icon_theme.dart';
import 'package:noty_mobile/data/repositories/auth_repository.dart';
import 'package:noty_mobile/domain/models/custom_user.dart';
import 'package:noty_mobile/features/add_car_plate/ui/add_palte_page.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

part 'profile_event.dart';

part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final AppRouterDelegate _appRouter;
  final AuthRepository _authRepository;

  ProfileBloc({
    required AppRouterDelegate appRouter,
    required AuthRepository authRepository,
  })  : _appRouter = appRouter,
        _authRepository = authRepository,
        super(LoadingState()) {
    on<LoadData>(_onLoadData);
    on<RouteToAddCarPlate>(_onRouteToAddCarPlate);
    on<PrintDocument>(_onPrintDocument);

    add(LoadData());
  }

  Future<void> _onLoadData(LoadData event, Emitter<ProfileState> emit) async {
    final CustomUser? user = await _authRepository.getUserAttributes();
    emit(ContentState(plate: user?.plate));
  }

  Future<void> _onRouteToAddCarPlate(RouteToAddCarPlate event, Emitter<ProfileState> emit) async {
    final String? plate = await _appRouter.pushForResult(
      AddPlatePage(),
    );

    if (plate != null && plate.isNotEmpty) {
      add(LoadData());
    }
  }

  Future<void> _onPrintDocument(PrintDocument event, Emitter<ProfileState> emit) async {
    final doc = pw.Document();
    final image = await imageFromAssetBundle(AppIconsTheme.print);
    final image2 = await flutterImageProvider(event.image.image);
    doc.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Stack(
            children: [
              pw.Image(image),
              pw.Align(
                  alignment: pw.Alignment.center,
                  child: pw.SizedBox(height: 80, width: 80, child: pw.Image(image2)))
            ],
          );
        },
      ),
    );

    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => doc.save());
  }
}
