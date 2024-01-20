import 'package:equatable/equatable.dart';
import 'package:flutter_blue/flutter_blue.dart';

abstract class RemoteServicesEvent extends Equatable {
  final BluetoothDevice? targetDevice;

  const RemoteServicesEvent({this.targetDevice});

  @override
  List<Object> get props => [targetDevice!];
}

class GetServices extends RemoteServicesEvent {
  const GetServices(BluetoothDevice targetDevice)
      : super(targetDevice: targetDevice);
}
