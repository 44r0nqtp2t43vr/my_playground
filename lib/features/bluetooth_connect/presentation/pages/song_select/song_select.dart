import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:my_playground/core/widgets/button.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_bloc.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_event.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_state.dart';
import 'package:my_playground/features/piano_tiles/data/data_sources/song_provider.dart';
import 'package:my_playground/injection_container.dart';

class SongSelect extends StatelessWidget {
  final BluetoothCharacteristic targetCharacteristic;

  const SongSelect({super.key, required this.targetCharacteristic});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<RemoteServicesBloc>()..add(UpdateCharaEvent(targetCharacteristic)),
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: _buildBody(context),
      ),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Song Select',
        style: TextStyle(color: Colors.black),
      ),
    );
  }

  _buildBody(BuildContext context) {
    return BlocBuilder<RemoteServicesBloc, RemoteServiceState>(
      builder: (_, state) {
        if (state is RemoteServiceDone) {
          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                const SizedBox(height: 16.0, width: double.infinity),
                Button(
                  onPressed: () =>
                      _onGameViewTapped(context, SongEnum.littleStar),
                  text: 'Little Star',
                ),
                const SizedBox(height: 16.0),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onGameViewTapped(BuildContext context, SongEnum songEnum) {
    Navigator.pushNamed(context, '/PlayGame',
        arguments: SongProvider().getSong(songEnum));
  }
}
