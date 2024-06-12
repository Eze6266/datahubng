import 'package:flutter_dotenv/flutter_dotenv.dart';

final dhubaseUrl = dotenv.env['BASE_URL'] ?? 'FALL_BACK_TEXT';

var baseUrl = dhubaseUrl;
