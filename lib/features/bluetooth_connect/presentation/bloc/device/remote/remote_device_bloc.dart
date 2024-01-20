import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_playground/features/bluetooth_connect/domain/usecases/get_scanres.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/device/remote/remote_device_event.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/device/remote/remote_device_state.dart';

class RemoteDevicesBloc extends Bloc<RemoteDevicesEvent, RemoteDeviceState> {
  final GetScanresUseCase _getScanresUseCase;

  RemoteDevicesBloc(this._getScanresUseCase) : super(const RemoteDeviceNone()) {
    on<GetDevices>(onGetDevices);
  }

  void onGetDevices(GetDevices event, Emitter<RemoteDeviceState> emit) async {
    final data = await _getScanresUseCase();
    emit(RemoteDeviceDone(data));
  }
}
