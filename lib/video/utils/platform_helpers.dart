import 'package:universal_platform/universal_platform.dart';

bool get isMobile => UniversalPlatform.isAndroid || UniversalPlatform.isIOS;
bool get isAndroid => UniversalPlatform.isAndroid;
bool get isIOS => UniversalPlatform.isIOS;
