import 'package:flutter/material.dart';

extension extOnDouble on num {
  sh() {
    return toDouble();
  }

  sw() {
    return toDouble();
  }
}

extension extOnWidget on Widget {
  get center {
    return Center(
      child: this,
    );
  }
}
