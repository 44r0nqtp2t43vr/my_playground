import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_playground/features/bluetooth_connect/domain/usecases/get_services.dart';
// import 'package:my_playground/features/bluetooth_connect/domain/usecases/refresh_services.dart';
import 'package:my_playground/features/bluetooth_connect/domain/usecases/restart_stream.dart';
import 'package:my_playground/features/bluetooth_connect/domain/usecases/stream_data.dart';
import 'package:my_playground/features/bluetooth_connect/domain/usecases/update_chara.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_event.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_state.dart';

class RemoteServicesBloc extends Bloc<RemoteServicesEvent, RemoteServiceState> {
  final GetServicesUseCase _getServicesUseCase;
  final UpdateCharaUseCase _updateCharaUseCase;
  final StreamDataUseCase _streamDataUseCase;
  final RestartStreamUseCase _restartStreamUseCase;
  // final RefreshServicesUseCase _refreshServicesUseCase;

  RemoteServicesBloc(
    this._getServicesUseCase,
    this._updateCharaUseCase,
    this._streamDataUseCase,
    this._restartStreamUseCase,
    // this._refreshServicesUseCase,
  ) : super(const RemoteServiceLoading()) {
    on<GetServices>(onGetServices);
    on<UpdateCharaEvent>(onUpdateChara);
    on<StreamDataEvent>(onStreamData);
    on<RestartStream>(onRestartStream);
  }

  void onGetServices(
      GetServices event, Emitter<RemoteServiceState> emit) async {
    final data = await _getServicesUseCase(params: event.targetDevice);
    emit(RemoteServiceDone(services: data));
  }

  void onUpdateChara(
      UpdateCharaEvent event, Emitter<RemoteServiceState> emit) async {
    await _updateCharaUseCase(params: event.targetCharacteristic);
    emit(const RemoteServiceDone());
  }

  void onStreamData(
      StreamDataEvent event, Emitter<RemoteServiceState> emit) async {
    await _streamDataUseCase(params: event.toStream);
    emit(RemoteServiceDone(toStream: event.toStream));
  }

  void onRestartStream(
      RestartStream event, Emitter<RemoteServiceState> emit) async {
    await _restartStreamUseCase(params: event.toStream);
    emit(RemoteServiceDone(toStream: event.toStream));
  }

  // void onSaveArticle(
  //     SaveArticle saveArticle, Emitter<LocalArticleState> emit) async {
  //   await _saveArticleUseCase(params: saveArticle.article);
  //   final articles = await _getSavedArticleUseCase();
  //   emit(LocalArticlesDone(articles));
  // }
}
