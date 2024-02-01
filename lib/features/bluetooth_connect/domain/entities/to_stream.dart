import 'package:equatable/equatable.dart';
import 'package:flutter_blue/flutter_blue.dart';

class ToStreamEntity extends Equatable {
  final BluetoothCharacteristic characteristic;
  final String data;
  final int duration;
  final int interval;

  const ToStreamEntity({
    required this.characteristic,
    required this.data,
    required this.duration,
    required this.interval,
  });

  @override
  List<Object?> get props {
    return [
      characteristic,
      data,
      duration,
      interval,
    ];
  }
}
