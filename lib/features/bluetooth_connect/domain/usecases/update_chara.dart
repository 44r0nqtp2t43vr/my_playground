import 'package:flutter_blue/flutter_blue.dart';
import 'package:my_playground/core/usecase/usecase.dart';
import 'package:my_playground/features/bluetooth_connect/domain/repository/device_repository.dart';

class UpdateCharaUseCase implements UseCase<void, BluetoothCharacteristic> {
  final DeviceRepository _deviceRepository;

  UpdateCharaUseCase(this._deviceRepository);

  @override
  Future<void> call({BluetoothCharacteristic? params}) {
    return _deviceRepository.updateCharacteristic(params!);
  }
}
