import 'package:equatable/equatable.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:my_playground/features/bluetooth_connect/domain/entities/to_stream.dart';

abstract class RemoteServicesEvent extends Equatable {
  final BluetoothDevice? targetDevice;
  final ToStreamEntity? toStream;

  const RemoteServicesEvent({this.targetDevice, this.toStream});

  @override
  List<Object> get props => [targetDevice!, toStream!];
}

class GetServices extends RemoteServicesEvent {
  const GetServices(BluetoothDevice targetDevice)
      : super(targetDevice: targetDevice);
}

class StreamDataEvent extends RemoteServicesEvent {
  const StreamDataEvent(ToStreamEntity toStream) : super(toStream: toStream);
}

class RestartStream extends RemoteServicesEvent {
  const RestartStream(ToStreamEntity toStream) : super(toStream: toStream);
}
