import 'dart:async';
import 'dart:convert' show utf8;

import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController {
  FlutterBlue flutterBlue = FlutterBlue.instance;

  late BluetoothDevice targetDevice;
  late BluetoothCharacteristic targetCharacteristic;
  late String toStreamData;
  late StreamController<String> streamController;
  late Timer streamingTimer;

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
  }

  Future writeData(
      BluetoothCharacteristic targetCharacteristic, String data) async {
    List<int> bytes = utf8.encode(data);
    await targetCharacteristic.write(bytes);
  }

  Future<void> writeStream(
    BluetoothCharacteristic newTargetCharacteristic,
    String data,
    int duration,
    int interval,
  ) async {
    targetCharacteristic = newTargetCharacteristic;
    streamController = StreamController<String>();
    // Subscribe to the streamController.stream and execute writeData when data is available
    streamController.stream.listen((addedData) async {
      await writeData(targetCharacteristic, addedData);
    });
    // Create a timer that repeats every [duration] milliseconds for a duration of [interval] milliseconds
    streamingTimer = Timer.periodic(
      Duration(milliseconds: interval),
      (Timer timer) {
        if (timer.tick <= (duration / interval)) {
          streamController.add("$data, $interval");
        } else {
          // Cancel the timer after [duration] milliseconds
          timer.cancel();
          // Close the stream controller to indicate that no more data will be added
          streamController.close();
        }
      },
    );
  }

  Future<void> restartStream(
    String data,
    int duration,
    int interval,
  ) async {
    if (!streamController.isClosed) {
      // Close current timer and stream
      streamingTimer.cancel();
      streamController.close();

      // Create a new stream controller
      streamController = StreamController<String>();

      // Subscribe to the streamController.stream and execute writeData when data is available
      streamController.stream.listen((addedData) async {
        await writeData(targetCharacteristic, addedData);
      });

      // Create a timer that repeats every [duration] milliseconds for a duration of [interval] milliseconds
      streamingTimer = Timer.periodic(
        Duration(milliseconds: interval),
        (Timer timer) {
          if (timer.tick <= (duration / interval)) {
            streamController.add("$data, $interval");
          } else {
            // Cancel the timer after [duration] milliseconds
            timer.cancel();
            // Close the stream controller to indicate that no more data will be added
            streamController.close();
          }
        },
      );
    } else {
      // Handle the case where streamController is null or already closed
    }
  }

  Stream<List<ScanResult>> get scanResults => flutterBlue.scanResults;
}
