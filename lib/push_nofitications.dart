import 'package:firebase_messaging/firebase_messaging.dart';
class PushNotificationsManager {

  PushNotificationsManager._();

  factory PushNotificationsManager() => _instance;

  static final PushNotificationsManager _instance = PushNotificationsManager._();

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  bool _initialized = false;

  Future<void> init() async {
    if (!_initialized) {
      // For iOS request permission first.
      _firebaseMessaging.requestPermission();
      // workaround for onLaunch: When the app is completely closed (not in the background) and opened directly from the push notification
      _firebaseMessaging.getInitialMessage().then((RemoteMessage message) {
        /*if (message != null) {
          _serialiseAndNavigate(message.data);
        }*/
      });

      // onMessage: When the app is open and it receives a push notification
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        //print("onMessage data: ${message.data}");
      });

      // replacement for onResume: When the app is in the background and opened directly from the push notification.
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        /*print('onMessageOpenedApp data: ${message.data}');
        _serialiseAndNavigate(message.data);*/
      });

      // For testing purposes print the Firebase Messaging token
      String token = await _firebaseMessaging.getToken();
      print("FirebaseMessaging token: $token");
      _initialized = true;
    }
  }

  void _serialiseAndNavigate(Map<String, dynamic> message) {
    print("navigate: $message");
    var notificationData = message['data'];
    print("navigatedata: $notificationData");
    var view = notificationData['view'];
    print("navigateview: $view");

    if (view != null) {
      // Navigate to the create post view
      if (view == 'create_post') {
        //_navigationService.navigateTo(CreatePostViewRoute);
      }
      // If there's no view it'll just open the app on the first view
    }
  }

}