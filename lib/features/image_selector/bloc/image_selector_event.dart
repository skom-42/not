import 'package:flutter/material.dart';

abstract class ImageSelectorEvent {}

class RouteBack extends ImageSelectorEvent {}

class SelectCameraImage extends ImageSelectorEvent {}

class SelectGalleryImage extends ImageSelectorEvent {}
