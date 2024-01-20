import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class DeviceCard extends StatelessWidget {
  final ScanResult device;
  final Function() onTap;

  const DeviceCard({super.key, required this.device, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Text(device.device.name),
          subtitle: Text(device.device.id.id),
          trailing: Text(device.rssi.toString()),
        ),
      ),
    );
  }
}
