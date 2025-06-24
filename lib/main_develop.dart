import 'flavors.dart';
import 'main.dart' as runner;

void main() {
  F.appFlavor = Flavor.develop;
  runner.main();
}
