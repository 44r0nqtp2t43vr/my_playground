import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/device/remote/remote_device_bloc.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/device/remote/remote_device_event.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/device/remote/remote_device_state.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/widgets/device_card.dart';
import 'package:my_playground/injection_container.dart';

class ViewDevices extends StatelessWidget {
  const ViewDevices({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RemoteDevicesBloc>(),
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: _buildBody(),
        floatingActionButton: _buildFloatingActionButton(),
      ),
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
    return BlocBuilder<RemoteDevicesBloc, RemoteDeviceState>(
      builder: (_, state) {
        if (state is RemoteDeviceNone) {
          return const Center(
            child: Text('Click the button to scan for devices'),
          );
        }
        if (state is RemoteDeviceDone) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 16),
                Expanded(
                  child: StreamBuilder<List<ScanResult>>(
                    stream: state.scanResults,
                    builder: (context, snapshot) {
                      if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                        return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index) {
                            final result = snapshot.data![index];
                            return DeviceCard(
                              device: result,
                              onTap: () =>
                                  _onDeviceCardPressed(context, result.device),
                            );
                          },
                        );
                      } else if (snapshot.hasData) {
                        return const Center(child: Text("No Device Found"));
                      } else {
                        return const Center(
                            child: CupertinoActivityIndicator());
                      }
                    },
                  ),
                ),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
    // return GetBuilder<BleController>(
    //   init: BleController(),
    //   builder: (controller) {
    //     return Center(
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           const SizedBox(height: 16),
    //           Expanded(
    //             child: StreamBuilder<List<ScanResult>>(
    //               stream: controller.scanResultsStream,
    //               builder: (context, snapshot) {
    //                 if (snapshot.hasData && snapshot.data!.isNotEmpty) {
    //                   return ListView.builder(
    //                     itemCount: snapshot.data!.length,
    //                     itemBuilder: (context, index) {
    //                       final data = snapshot.data![index];
    //                       return Card(
    //                         elevation: 2,
    //                         child: InkWell(
    //                           onTap: () async {
    //                             controller.targetDevice = data.device;
    //                             await controller.connectToDevice();
    //                           },
    //                           child: ListTile(
    //                             title: Text(data.device.name),
    //                             subtitle: Text(data.device.id.id),
    //                             trailing: Text(data.rssi.toString()),
    //                           ),
    //                         ),
    //                       );
    //                     },
    //                   );
    //                 } else {
    //                   return const Center(child: Text("No Device Found"));
    //                 }
    //               },
    //             ),
    //           ),
    //           ElevatedButton(
    //             onPressed: () => controller.scanDevices(),
    //             child: const Text("Scan"),
    //           ),
    //           const SizedBox(height: 16),
    //           ElevatedButton(
    //             onPressed: () => controller.discoverServices(),
    //             child: const Text("Write"),
    //           ),
    //           const SizedBox(height: 16),
    //         ],
    //       ),
    //     );
    //   },
    // );
  }

  Widget _buildFloatingActionButton() {
    return Builder(
      builder: (context) => FloatingActionButton(
        onPressed: () => _onFloatingActionButtonPressed(context),
        child: const Icon(Icons.search, color: Colors.white),
      ),
    );
  }

  void _onFloatingActionButtonPressed(BuildContext context) {
    BlocProvider.of<RemoteDevicesBloc>(context).add(const GetDevices());
    // ScaffoldMessenger.of(context).showSnackBar(
    //   const SnackBar(
    //     backgroundColor: Colors.black,
    //     content: Text('Scanning devices...'),
    //   ),
    // );
  }

  void _onDeviceCardPressed(
      BuildContext context, BluetoothDevice targetDevice) {
    // BlocProvider.of<RemoteServicesBloc>(context).add(GetServices(targetDevice));
    Navigator.pushNamed(context, '/ViewServices', arguments: targetDevice);
  }

  void _onDailyNewsViewTapped(BuildContext context) {
    Navigator.pushNamed(context, '/DailyNews');
  }
}
