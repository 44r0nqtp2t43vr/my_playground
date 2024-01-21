import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_playground/features/bluetooth_connect/domain/usecases/get_services.dart';
import 'package:my_playground/features/bluetooth_connect/domain/usecases/refresh_services.dart';
import 'package:my_playground/features/bluetooth_connect/domain/usecases/stream_data.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_event.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_state.dart';

class RemoteServicesBloc extends Bloc<RemoteServicesEvent, RemoteServiceState> {
  final GetServicesUseCase _getServicesUseCase;
  final StreamDataUseCase _streamDataUseCase;
  final RefreshServicesUseCase _refreshServicesUseCase;

  RemoteServicesBloc(
    this._getServicesUseCase,
    this._streamDataUseCase,
    this._refreshServicesUseCase,
  ) : super(const RemoteServiceLoading()) {
    on<GetServices>(onGetServices);
    on<StreamData>(onStreamData);
  }

  void onGetServices(
      GetServices event, Emitter<RemoteServiceState> emit) async {
    final data = await _getServicesUseCase(params: event.targetDevice);
    emit(RemoteServiceDone(data));
  }

  void onStreamData(StreamData event, Emitter<RemoteServiceState> emit) async {
    await _streamDataUseCase(params: event.toStream);
    final services = await _refreshServicesUseCase();
    emit(RemoteServiceDone(services));
  }

  // void onSaveArticle(
  //     SaveArticle saveArticle, Emitter<LocalArticleState> emit) async {
  //   await _saveArticleUseCase(params: saveArticle.article);
  //   final articles = await _getSavedArticleUseCase();
  //   emit(LocalArticlesDone(articles));
  // }
}
