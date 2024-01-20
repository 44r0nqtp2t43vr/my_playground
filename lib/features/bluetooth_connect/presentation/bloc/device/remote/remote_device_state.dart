import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_blue/flutter_blue.dart';

abstract class RemoteDeviceState extends Equatable {
  final Stream<List<ScanResult>>? scanResults;
  final DioException? error;

  const RemoteDeviceState({this.scanResults, this.error});

  @override
  List<Object> get props => [scanResults!, error!];
}

class RemoteDeviceNone extends RemoteDeviceState {
  const RemoteDeviceNone();
}

class RemoteDeviceLoading extends RemoteDeviceState {
  const RemoteDeviceLoading();
}

class RemoteDeviceDone extends RemoteDeviceState {
  const RemoteDeviceDone(Stream<List<ScanResult>> scanResults)
      : super(scanResults: scanResults);
}

// class RemoteDeviceError extends RemoteDeviceState {
//   const RemoteDeviceError(DioException error) : super(error: error);
// }
