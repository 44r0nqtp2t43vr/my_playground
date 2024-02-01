import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter_bloc/flutter_bloc.dart";
import "package:my_playground/features/bluetooth_connect/domain/entities/to_stream.dart";
import "package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_bloc.dart";
import "package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_event.dart";
import "package:my_playground/features/bluetooth_connect/presentation/bloc/service/remote/remote_service_state.dart";
import "package:my_playground/injection_container.dart";

class StreamData extends StatefulWidget {
  final ToStreamEntity toStreamEntity;

  const StreamData({super.key, required this.toStreamEntity});

  @override
  State<StreamData> createState() => _StreamDataState();
}

class _StreamDataState extends State<StreamData> {
  late double _position;

  @override
  void initState() {
    super.initState();
    _position = widget.toStreamEntity.interval.toDouble();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          sl<RemoteServicesBloc>()..add(StreamDataEvent(widget.toStreamEntity)),
      child: Scaffold(
        appBar: _buildAppbar(context),
        body: _buildBody(context),
      ),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Streaming Data',
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
                Text(
                    '${state.toStream!.characteristic.uuid.toString()} ${state.toStream!.interval}'),
                Slider(
                  value: _position,
                  min: 0.0,
                  max: 2000.0,
                  onChanged: (value) {
                    setState(() {
                      _position = value;
                    });
                    onSliderUpdate(state.toStream!, value.toInt());
                  },
                ),
                Text(_position.toInt().toString()),
              ],
            ),
          );
        }
        return const SizedBox();
      },
    );
  }

  void onSliderUpdate(ToStreamEntity toStream, int newInterval) {
    ToStreamEntity newToStream = ToStreamEntity(
      characteristic: toStream.characteristic,
      data: toStream.data,
      duration: toStream.duration,
      interval: newInterval,
    );
    sl<RemoteServicesBloc>().add(RestartStream(newToStream));
  }
}
