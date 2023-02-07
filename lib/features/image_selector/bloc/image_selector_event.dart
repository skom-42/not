import 'package:flutter/material.dart';

abstract class ImageSelectorEvent {}

class RouteBack extends ImageSelectorEvent {}

class SelectCameraImage extends ImageSelectorEvent {
  final Function onClose;

  SelectCameraImage({required this.onClose});
}

class SelectGalleryImage extends ImageSelectorEvent {
  final Function onClose;

  SelectGalleryImage({required this.onClose});
}
