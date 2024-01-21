import 'package:my_playground/core/usecase/usecase.dart';
import 'package:my_playground/features/bluetooth_connect/domain/entities/to_stream.dart';
import 'package:my_playground/features/bluetooth_connect/domain/repository/device_repository.dart';

class StreamDataUseCase implements UseCase<void, ToStreamEntity> {
  final DeviceRepository _deviceRepository;

  StreamDataUseCase(this._deviceRepository);

  @override
  Future<void> call({ToStreamEntity? params}) {
    return _deviceRepository.streamData(params!.characteristic, params.data);
  }
}
