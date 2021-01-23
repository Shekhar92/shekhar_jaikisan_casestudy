import 'package:permission_handler/permission_handler.dart';

class PermissionUtils {

  Future<bool> requestPermission() async {
    bool isGranted = true;
    Map<Permission, PermissionStatus> statuses = await [
      Permission.location,
      Permission.storage,
    ].request();

    for (int i = 0; i < statuses.length; i++) {
      if (!statuses[i].isGranted) {
        isGranted = false;
      }
    }
    return isGranted;
  }

  Future<bool> checkPermissionPermanentlyDenied() async{
    if (await Permission.storage.request().isPermanentlyDenied ||
        await Permission.location.request().isPermanentlyDenied) {
      return true;
    }
  }
}