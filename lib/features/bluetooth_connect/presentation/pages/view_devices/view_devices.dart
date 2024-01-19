import 'dart:async';
import 'dart:convert' show utf8;

import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class BleController extends GetxController {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  late BluetoothDevice targetDevice;

  Future scanDevices() async {
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
  }

  Future connectToDevice() async {
    print('connecting');
    await targetDevice.connect(autoConnect: false);
  }

  Future disconnectFromDevice() async {
    await targetDevice.disconnect();
  }

  Future discoverServices() async {
    List<BluetoothService> services = await targetDevice.discoverServices();
    services.forEach((service) {
      service.characteristics.forEach((characteristic) {
        print(characteristic.properties.toString());
        if (characteristic.properties.write == true) {
          writeStream(characteristic, "255255255");
        }
      });
    });
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
    Timer.periodic(Duration(milliseconds: 20), (Timer timer) {
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

class ViewDevices extends StatefulWidget {
  const ViewDevices({super.key});

  @override
  State<ViewDevices> createState() => _ViewDevicesState();
}

class _ViewDevicesState extends State<ViewDevices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Bluetooth Devices',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        GestureDetector(
          onTap: () => _onDailyNewsViewTapped(context),
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 14),
            child: Icon(Icons.newspaper, color: Colors.black),
          ),
        ),
      ],
    );
  }

  _buildBody() {
    // return BlocBuilder<RemoteArticlesBloc, RemoteArticleState> (
    //   builder: (_,state) {
    //     if (state is RemoteArticlesLoading) {
    //       return const Center(child: CupertinoActivityIndicator());
    //     }
    //     if (state is RemoteArticlesError) {
    //       return const Center(child: Icon(Icons.refresh));
    //     }
    //     if (state is RemoteArticlesDone) {
    //       return ListView.builder(
    //        itemBuilder: (context,index){
    //         return const SizedBox();
    //         // return ArticleWidget(
    //         //   article: state.articles![index] ,
    //         //   onArticlePressed: (article) => _onArticlePressed(context,article),
    //         // );
    //        },
    //        itemCount: state.articles!.length,
    //      );
    //     }
    //     return const SizedBox();
    //   },
    // );
    return GetBuilder<BleController>(
      init: BleController(),
      builder: (controller) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              Expanded(
                child: StreamBuilder<List<ScanResult>>(
                  stream: controller.scanResults,
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                      return ListView.builder(
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, index) {
                          final data = snapshot.data![index];
                          return Card(
                            elevation: 2,
                            child: InkWell(
                              onTap: () async {
                                controller.targetDevice = data.device;
                                await controller.connectToDevice();
                              },
                              child: ListTile(
                                title: Text(data.device.name),
                                subtitle: Text(data.device.id.id),
                                trailing: Text(data.rssi.toString()),
                              ),
                            ),
                          );
                        },
                      );
                    } else {
                      return const Center(child: Text("No Device Found"));
                    }
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () => controller.scanDevices(),
                child: const Text("Scan"),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => controller.discoverServices(),
                child: const Text("Write"),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }

  void _onDailyNewsViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/DailyNews');
  }
}
