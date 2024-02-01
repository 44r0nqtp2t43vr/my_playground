import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:my_playground/features/bluetooth_connect/domain/entities/to_stream.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_bloc.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_event.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_state.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/widgets/chara_card.dart';
import 'package:my_playground/injection_container.dart';

class ViewServices extends StatelessWidget {
  final BluetoothDevice targetDevice;

  const ViewServices({super.key, required this.targetDevice});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<RemoteServicesBloc>()..add(GetServices(targetDevice)),
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: _buildBody(context),
      ),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Bluetooth Services',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return BlocBuilder<RemoteServicesBloc, RemoteServiceState>(
      builder: (_, state) {
        if (state is RemoteServiceLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is RemoteServiceDone) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                for (var service in state.services!) ...[
                  Text('UUID: ${service.uuid.toString()}'),
                  Column(
                    children: [
                      for (var characteristic in service.characteristics) ...[
                        CharaCard(
                          onTap: () => _onCharaCardPressed(
                            context,
                            characteristic,
                            "255255255",
                            1000 * 60 * 60,
                            1000,
                          ),
                          characteristic: characteristic,
                        ),
                      ],
                    ],
                  ),
                  const SizedBox(height: 16.0),
                ],
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onCharaCardPressed(
    BuildContext context,
    BluetoothCharacteristic characteristic,
    String data,
    int duration,
    int interval,
  ) {
    ToStreamEntity toStreamEntity = ToStreamEntity(
      characteristic: characteristic,
      data: data,
      duration: duration,
      interval: interval,
    );
    // sl<RemoteServicesBloc>().add(StreamData(toStreamEntity));
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     backgroundColor: Colors.black,
    //     content: Text('Streaming to ${characteristic.uuid.toString()}...'),
    //   ),
    // );
    Navigator.pushNamed(context, '/StreamData', arguments: toStreamEntity);
  }
}
