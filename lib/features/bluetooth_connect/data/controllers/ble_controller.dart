import 'dart:async';
import 'dart:convert' show utf8;

import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  late BluetoothDevice targetDevice;

  Future<Stream<List<ScanResult>>> scanDevices() async {
    var blePermission = await Permission.bluetoothScan.status;
    if (blePermission.isDenied) {
      if (await Permission.bluetoothScan.request().isGranted) {
        if (await Permission.bluetoothConnect.request().isGranted) {
          flutterBlue.startScan(timeout: const Duration(seconds: 2));
          flutterBlue.stopScan();
        }
      }
    } else {
      flutterBlue.startScan(timeout: const Duration(seconds: 2));
      flutterBlue.stopScan();
    }
    return scanResults;
  }

  Future connectToDevice(BluetoothDevice device) async {
    targetDevice = device;
    await targetDevice.connect(autoConnect: false);
  }

  Future disconnectFromDevice() async {
    await targetDevice.disconnect();
  }

  Future<List<BluetoothService>> discoverServices() async {
    List<BluetoothService> services = await targetDevice.discoverServices();
    return services;
    // services.forEach((service) {
    //   print(service.uuid);
    //   service.characteristics.forEach((characteristic) {
    //     print(characteristic.properties.toString());
    //     if (characteristic.properties.write == true) {
    //       writeStream(characteristic, "255255255");
    //     }
    //   });
    // });
  }

  Future writeData(
      BluetoothCharacteristic targetCharacteristic, String data) async {
    List<int> bytes = utf8.encode(data);
    await targetCharacteristic.write(bytes);
  }

  Future writeStream(
      BluetoothCharacteristic targetCharacteristic, String data) async {
    StreamController<String> writeDataStreamController =
        StreamController<String>();
    // Subscribe to the writeDataStreamController.stream and execute writeData when data is available
    writeDataStreamController.stream.listen((addedData) async {
      await writeData(targetCharacteristic, addedData);
    });
    // Create a timer that repeats every 20 milliseconds for a duration of 2 seconds
    Timer.periodic(const Duration(milliseconds: 20), (Timer timer) {
      if (timer.tick <= (2000 / 20)) {
        writeDataStreamController.add(data);
      } else {
        // Cancel the timer after 2 seconds
        timer.cancel();
        // Close the stream controller to indicate that no more data will be added
        writeDataStreamController.close();
      }
    });
  }

  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;
}
