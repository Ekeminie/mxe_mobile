import 'package:flutter_dotenv/flutter_dotenv.dart';

/**
 * this class has all network configurations
 */
class NetworkConfig {
  static String baseUrl = dotenv.env['BASE_URL']! ?? "";
}
