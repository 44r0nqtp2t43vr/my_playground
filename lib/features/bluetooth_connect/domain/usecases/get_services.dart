import 'package:flutter_blue/flutter_blue.dart';
import 'package:my_playground/core/usecase/usecase.dart';
import 'package:my_playground/features/bluetooth_connect/domain/repository/device_repository.dart';

class GetServicesUseCase
    implements UseCase<List<BluetoothService>, BluetoothDevice> {
  final DeviceRepository _deviceRepository;

  GetServicesUseCase(this._deviceRepository);

  @override
  Future<List<BluetoothService>> call({BluetoothDevice? params}) async {
    await _deviceRepository.connectToDevice(params!);
    return _deviceRepository.getServices();
  }
}
