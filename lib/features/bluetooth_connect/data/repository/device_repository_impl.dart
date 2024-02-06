import 'package:flutter_blue/flutter_blue.dart';
import 'package:my_playground/features/bluetooth_connect/data/controllers/ble_controller.dart';
import 'package:my_playground/features/bluetooth_connect/domain/repository/device_repository.dart';

class DeviceRepositoryImpl implements DeviceRepository {
  final BleController _controller;

  DeviceRepositoryImpl(this._controller);

  @override
  Future<Stream<List<ScanResult>>> getScanResults() async {
    final scanResults = await _controller.scanDevices();
    return scanResults;
  }

  @override
  Future<List<BluetoothService>> getServices() async {
    final services = await _controller.discoverServices();
    return services;
  }

  @override
  Future<void> connectToDevice(BluetoothDevice targetDevice) async {
    await _controller.connectToDevice(targetDevice);
  }

  @override
  Future<void> updateCharacteristic(
      BluetoothCharacteristic targetCharacteristic) {
    _controller.updateCharacteristic(targetCharacteristic);
    return Future.value(null);
  }

  @override
  Future<void> writeData(String data) async {
    await _controller.writeData(data);
  }

  @override
  Future<void> streamData(
    BluetoothCharacteristic characteristic,
    String data,
    int duration,
    int interval,
  ) async {
    await _controller.writeStream(characteristic, data, duration, interval);
  }

  @override
  Future<void> restartStream(
    String data,
    int duration,
    int interval,
  ) async {
    await _controller.restartStream(data, duration, interval);
  }
}
