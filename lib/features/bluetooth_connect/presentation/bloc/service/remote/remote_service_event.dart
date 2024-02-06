import 'package:equatable/equatable.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:my_playground/features/bluetooth_connect/domain/entities/to_stream.dart';

abstract class RemoteServicesEvent extends Equatable {
  final BluetoothDevice? targetDevice;
  final BluetoothCharacteristic? targetCharacteristic;
  final ToStreamEntity? toStream;
  final String? data;

  const RemoteServicesEvent(
      {this.targetDevice, this.targetCharacteristic, this.toStream, this.data});

  @override
  List<Object> get props => [targetDevice!, toStream!];
}

class GetServices extends RemoteServicesEvent {
  const GetServices(BluetoothDevice targetDevice)
      : super(targetDevice: targetDevice);
}

class UpdateCharaEvent extends RemoteServicesEvent {
  const UpdateCharaEvent(BluetoothCharacteristic targetCharacteristic)
      : super(targetCharacteristic: targetCharacteristic);
}

class WriteDataEvent extends RemoteServicesEvent {
  const WriteDataEvent(String data) : super(data: data);
}

class StreamDataEvent extends RemoteServicesEvent {
  const StreamDataEvent(ToStreamEntity toStream) : super(toStream: toStream);
}

class RestartStream extends RemoteServicesEvent {
  const RestartStream(ToStreamEntity toStream) : super(toStream: toStream);
}
