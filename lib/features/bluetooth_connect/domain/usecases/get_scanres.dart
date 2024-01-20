import 'package:flutter_blue/flutter_blue.dart';
import 'package:my_playground/core/usecase/usecase.dart';
import 'package:my_playground/features/bluetooth_connect/domain/repository/device_repository.dart';

class GetScanresUseCase implements UseCase<Stream<List<ScanResult>>, void> {
  final DeviceRepository _deviceRepository;

  GetScanresUseCase(this._deviceRepository);

  @override
  Future<Stream<List<ScanResult>>> call({void params}) {
    return _deviceRepository.getScanResults();
  }
}
