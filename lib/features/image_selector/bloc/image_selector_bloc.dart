import 'dart:async';
import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:navigation/navigation.dart';

import 'image_selector_event.dart';
import 'image_selector_state.dart';

class ImageSelectorBloc extends Bloc<ImageSelectorEvent, ImageSelectorState> {
  final AppRouterDelegate appRouter;

  ImageSelectorBloc({
    required this.appRouter,
  }) : super(ImageSelectorContent());

  @override
  Stream<ImageSelectorState> mapEventToState(ImageSelectorEvent event) async* {
    if (event is RouteBack) {
      appRouter.popWithResult(null);
    }

    if (event is SelectCameraImage) {
      final File? image = await _getImage(ImageSource.camera);
      // appRouter.popWithResult(image);
      event.onClose(image);
    }

    if (event is SelectGalleryImage) {
      final File? image = await _getImage(ImageSource.gallery);
      // appRouter.popWithResult(image);
      event.onClose(image);

    }
  }

  Future<File?> _getImage(ImageSource dataSource) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: dataSource);
      if (image != null) {
        final File temporaryImage = File(image.path);
        return temporaryImage;
      } else {
        return null;
      }
    } on PlatformException catch (e) {
      print(e);
    }
  }
}
