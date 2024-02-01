import 'package:flutter_blue/flutter_blue.dart';
// import 'package:my_playground/features/daily_news/domain/entities/article.dart';

abstract class DeviceRepository {
  // API methods
  Future<Stream<List<ScanResult>>> getScanResults();
  Future<List<BluetoothService>> getServices();
  Future<void> connectToDevice(BluetoothDevice targetDevice);
  Future<void> streamData(
    BluetoothCharacteristic characteristic,
    String data,
    int duration,
    int interval,
  );
  Future<void> restartStream(
    String data,
    int duration,
    int interval,
  );

  // Database methods
  // Future<List<ArticleEntity>> getSavedArticles();
  // Future<void> saveArticle(ArticleEntity article);
  // Future<void> removeArticle(ArticleEntity article);
}
