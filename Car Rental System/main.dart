import 'CarRentalSys.dart';
import 'DummyData/dummy.dart';

void main() {
  CarRentalSystem system = CarRentalSystem(true);

  DummyData.doo(system);

  system.GenerateReports();
}
