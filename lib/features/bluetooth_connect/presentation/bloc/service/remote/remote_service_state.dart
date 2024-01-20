import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue/flutter_blue.dart';

abstract class RemoteServiceState extends Equatable {
  final List<BluetoothService>? services;
  final DioException? error;

  const RemoteServiceState({this.services, this.error});

  @override
  List<Object> get props => [services!, error!];
}

class RemoteServiceNone extends RemoteServiceState {
  const RemoteServiceNone();
}

class RemoteServiceLoading extends RemoteServiceState {
  const RemoteServiceLoading();
}

class RemoteServiceDone extends RemoteServiceState {
  const RemoteServiceDone(List<BluetoothService> services)
      : super(services: services);
}
