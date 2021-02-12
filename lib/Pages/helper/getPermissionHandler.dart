import 'package:call_log/call_log.dart';
import 'package:permission_handler/permission_handler.dart';

class GetPermissionHandler {
  checkCallLogPermission() async {
    var statusPhonePermission = await Permission.phone.status;
    if (statusPhonePermission.isGranted) {
      Iterable<CallLogEntry> entries  = await   CallLog.get();
      for(var en in entries){
        print(en.number);
      }
    }
  }
}
