import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../features/auth/domain/usecases/sessioncontroller.dart';

Future<List<bool>> getData() async {
  List<bool> isDisplay = [];
  await FirebaseFirestore.instance
      .collection("startup")
      .doc(SessionController().userId)
      .get()
      .then((value) {
    isDisplay.add(value['display_lang']);
    isDisplay.add(value['display_switch']);
  });

  return isDisplay;
}
