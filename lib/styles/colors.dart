import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

final Color darkBlue = Color.fromRGBO(33, 53, 85, 1);
final Color lightBlue = Color.fromRGBO(62, 88, 121, 1);
final Color beige = Color.fromRGBO(216, 196, 182, 1);
final Color cream = Color.fromRGBO(245, 239, 231, 1);

void configureEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..indicatorType = EasyLoadingIndicatorType.fadingCircle
    ..maskType = EasyLoadingMaskType.custom
    ..animationStyle = EasyLoadingAnimationStyle.opacity
    ..toastPosition = EasyLoadingToastPosition.center
    ..textAlign = TextAlign.center
    ..indicatorSize = 50.0
    ..radius = 15.0
    ..fontSize = 16.0
    ..lineWidth = 4.0
    ..indicatorColor = darkBlue
    ..progressColor = lightBlue
    ..backgroundColor = Colors.white
    ..textColor = Colors.white
    ..maskColor = Colors.black.withAlpha(204)
    ..userInteractions = false
    ..dismissOnTap = false;
}
