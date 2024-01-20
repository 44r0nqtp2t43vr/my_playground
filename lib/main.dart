import 'package:flutter/material.dart';
import 'package:my_playground/config/routes/routes.dart';
import 'package:my_playground/config/theme/app_themes.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/pages/view_devices/view_devices.dart';
import 'package:my_playground/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return BlocProvider<RemoteArticlesBloc>(
    //   create: (context) => sl()..add(const GetArticles()),
    //   child: MaterialApp(
    //     theme: theme(),
    //     onGenerateRoute: AppRoutes.onGenerateRoutes,
    //     home: const ViewDevices(),
    //   ),
    // );
    return MaterialApp(
      theme: theme(),
      onGenerateRoute: AppRoutes.onGenerateRoutes,
      home: const ViewDevices(),
    );
  }
}
