import 'package:equatable/equatable.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ToStreamEntity extends Equatable {
  final BluetoothCharacteristic characteristic;
  final String data;

  const ToStreamEntity({required this.characteristic, required this.data});

  @override
  List<Object?> get props {
    return [
      characteristic,
      data,
    ];
  }
}
