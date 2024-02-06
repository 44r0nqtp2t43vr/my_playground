import 'package:my_playground/core/usecase/usecase.dart';
import 'package:my_playground/features/bluetooth_connect/domain/repository/device_repository.dart';

class WriteDataUseCase implements UseCase<void, String?> {
  final DeviceRepository _deviceRepository;

  WriteDataUseCase(this._deviceRepository);

  @override
  Future<void> call({String? params}) {
    return _deviceRepository.writeData(params!);
  }
}
