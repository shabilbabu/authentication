import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WraperController extends GetxController {

  WraperController(){
    checkInAuthentication();
  }

  checkInAuthentication() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final result = prefs.getString('user');
    return result == null ? false : true;
  }
}
