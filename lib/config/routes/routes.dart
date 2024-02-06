import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';
import 'package:my_playground/features/bluetooth_connect/domain/entities/to_stream.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/pages/song_select/song_select.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/pages/stream_data/stream_data.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/pages/view_devices/view_devices.dart';
import 'package:my_playground/features/bluetooth_connect/presentation/pages/view_services.dart/view_services.dart';
import 'package:my_playground/features/piano_tiles/domain/entities/song.dart';
import 'package:my_playground/features/piano_tiles/presentation/pages/play_game/play_game.dart';
import 'package:my_playground/features/user/presentation/pages/login/login_screen.dart';
import 'package:my_playground/features/user/presentation/pages/register/register_screen.dart';

import '../../features/daily_news/domain/entities/article.dart';
import '../../features/daily_news/presentation/pages/article_detail/article_detail.dart';
import '../../features/daily_news/presentation/pages/home/daily_news.dart';
import '../../features/daily_news/presentation/pages/saved_article/saved_article.dart';

class AppRoutes {
  static Route onGenerateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return _materialRoute(const LoginScreen());

      case '/Login':
        return _materialRoute(const LoginScreen());

      case '/Register':
        return _materialRoute(const RegisterScreen());

      case '/PlayGame':
        return _materialRoute(PlayGame(song: settings.arguments as Song));

      case '/ViewDevices':
        return _materialRoute(const ViewDevices());

      case '/ViewServices':
        return _materialRoute(
            ViewServices(targetDevice: settings.arguments as BluetoothDevice));

      case '/SongSelect':
        return _materialRoute(SongSelect(
            targetCharacteristic:
                settings.arguments as BluetoothCharacteristic));

      case '/StreamData':
        return _materialRoute(
            StreamData(toStreamEntity: settings.arguments as ToStreamEntity));

      case '/DailyNews':
        return _materialRoute(const DailyNews());

      case '/ArticleDetails':
        return _materialRoute(
            ArticleDetailsView(article: settings.arguments as ArticleEntity));

      case '/SavedArticles':
        return _materialRoute(const SavedArticles());

      default:
        return _materialRoute(const LoginScreen());
    }
  }

  static Route<dynamic> _materialRoute(Widget view) {
    return MaterialPageRoute(builder: (_) => view);
  }
}
