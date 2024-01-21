import 'package:flutter_blue/flutter_blue.dart';
import 'package:my_playground/core/usecase/usecase.dart';
import 'package:my_playground/features/bluetooth_connect/domain/repository/device_repository.dart';

class RefreshServicesUseCase implements UseCase<List<BluetoothService>, void> {
  final DeviceRepository _deviceRepository;

  RefreshServicesUseCase(this._deviceRepository);

  @override
  Future<List<BluetoothService>> call({void params}) async {
    return _deviceRepository.getServices();
  }
}
