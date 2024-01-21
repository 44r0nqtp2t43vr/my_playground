import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class CharaCard extends StatelessWidget {
  final BluetoothCharacteristic characteristic;
  final Function() onTap;

  const CharaCard(
      {super.key, required this.characteristic, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        child: ListTile(
          title: Text(characteristic.uuid.toString()),
          subtitle: Text(
              'Supports write: ${characteristic.properties.write.toString()}'),
        ),
      ),
    );
  }
}
