// 认为只要是PermissionStatus.granted或者PermissionStatus.limited就算是拥有权限
import 'package:permission_handler/permission_handler.dart';
export 'package:permission_handler/permission_handler.dart';

class Permissions {
  // ************************ 单一权限获取 ************************
  static Future<bool> request(String type) async {
    bool result = false;

    // 获取访问相册权限
    if (type == "photos") {
      Map<Permission, PermissionStatus> statuses =
          await [Permission.photos].request();
      PermissionStatus? _result = statuses[Permission.photos];
      print(_result);
      result = _result == PermissionStatus.granted ||
          _result == PermissionStatus.limited;
    }

    // 获取相机拍照权限
    else if (type == "camera") {
      Map<Permission, PermissionStatus> statuses =
          await [Permission.camera].request();
      PermissionStatus? _result = statuses[Permission.camera];
      print(_result);
      result = _result == PermissionStatus.granted ||
          _result == PermissionStatus.limited;
    }

    return result;
  }
}
