import 'package:flutter/foundation.dart';

class AppDataProvider with ChangeNotifier {
  int _unReadNotificationCount = 0;

  int get unReadNotificationCount => _unReadNotificationCount;

  void updateCount(int newCount) {
    if (newCount != _unReadNotificationCount) {
      _unReadNotificationCount = newCount;
      notifyListeners();
    }
  }

  void incrementCount() {
    _unReadNotificationCount++;
    notifyListeners();
  }
}
