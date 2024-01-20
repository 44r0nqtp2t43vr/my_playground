import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_bloc.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_event.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_state.dart';
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
        body: _buildBody(),
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

  _buildBody() {
    return BlocBuilder<RemoteServicesBloc, RemoteServiceState>(
      builder: (_, state) {
        if (state is RemoteServiceLoading) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        }
        if (state is RemoteServiceDone) {
          return Center(
            child: ListView.builder(
              itemCount: state.services!.length,
              itemBuilder: (context, index) {
                final data = state.services![index];
                return Card(
                  elevation: 2,
                  child: InkWell(
                    onTap: () {},
                    child: ListTile(
                      title: Text(data.deviceId.id),
                      subtitle: Text(data.uuid.toString()),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const SizedBox();
      },
    );
  }
}
