import 'package:flutter/material.dart';
import 'flavors.dart';
import 'main.dart' as runner;

void main() {
  F.appFlavor = Flavor.staging;
  runner.main();
}
