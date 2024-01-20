import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_playground/features/bluetooth_connect/domain/usecases/get_services.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_event.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_state.dart';

class RemoteServicesBloc extends Bloc<RemoteServicesEvent, RemoteServiceState> {
  final GetServicesUseCase _getServicesUseCase;

  RemoteServicesBloc(this._getServicesUseCase)
      : super(const RemoteServiceLoading()) {
    on<GetServices>(onGetServices);
  }

  void onGetServices(
      GetServices event, Emitter<RemoteServiceState> emit) async {
    final data = await _getServicesUseCase(params: event.targetDevice);
    emit(RemoteServiceDone(data));
  }
}
