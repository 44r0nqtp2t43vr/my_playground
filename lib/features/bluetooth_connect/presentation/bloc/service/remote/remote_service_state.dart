import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:my_playground/features/bluetooth_connect/domain/entities/to_stream.dart';

abstract class RemoteServiceState extends Equatable {
  final List<BluetoothService>? services;
  final ToStreamEntity? toStream;
  final DioException? error;

  const RemoteServiceState({this.services, this.toStream, this.error});

  @override
  List<Object> get props => [services!, toStream!, error!];
}

class RemoteServiceNone extends RemoteServiceState {
  const RemoteServiceNone();
}

class RemoteServiceLoading extends RemoteServiceState {
  const RemoteServiceLoading();
}

class RemoteServiceDone extends RemoteServiceState {
  const RemoteServiceDone({super.services, super.toStream});
}
